local awful     = require("awful")
local wibox     = require("wibox")
local gears     = require("gears")
-- local beautiful = require("beautiful")
-- local naughty   = require("naughty")

local osd = require('widget.osd')

local mpris = {
  worker_list = {},
  state = {},
  players = { "mpd", "kdeconnect" },
  timer = nil,
}

function mpris:init() 
  self.timer = gears.timer {
    timeout = 2,
    autostart = true,
    callback = function() mpris:update_workers{} end
  }
end

function mpris:update_workers(args)
  local player = args.player or 1 -- Start with players[1]
  local base = "playerctl -p %s metadata && printf 'm mpris:state %%s\nm mpris:volume %%s' $(playerctl status) $(playerctl volume)"
  local cmd = string.format(base, self.players[player])

  local function parse_state(playerctl_output)
    for line in string.gmatch(playerctl_output, "[^\n]+") do
      for k, v in string.gmatch(line, ".*[%s]([%w]+:[%w]+)[%s]+(.*)$") do
        self.state[k] = v:gsub("'", "")
      end
    end
  end

  local function set_worker_text(text)
    for _, worker in ipairs(self.worker_list) do
      worker:set_markup_silently(text)
    end
  end

  awful.spawn.easy_async_with_shell(cmd, function(stdout, _, _, exit_code)
    local function next_player() self:update_workers{player = player+1} end

    if (player > #self.players) then -- If there are no more players left
      set_worker_text("Nothing playing")
      return
    end

    if (exit_code ~= 0) then -- If player is invalid (or not active)
      next_player()
      return
    end

    parse_state(stdout)

    local trackid = string.match(self.state["mpris:trackid"], ".*/(.*)$")
    if (trackid == "NoTrack") then -- If no track is playing (mpd-mpris)
      next_player()
      return
    end
    local play_state = self.state["mpris:state"] == "Playing" and ">" or "="

    set_worker_text(play_state.." "..self.state["xesam:title"].." - "..self.state["xesam:artist"])
  end)
end

local _M = {}

function _M.new_worker(_)
  if (mpris.timer == nil and #mpris.worker_list == 0) then
    mpris:init()
  end

  local widget = wibox.widget {
    widget = wibox.widget.textbox,
    align = "center",
    valign = "center",
  }

  table.insert(mpris.worker_list, widget)
  mpris:update_workers{}

  return widget
end

function _M.toggle_pause() 
  local cmd = string.format("playerctl play-pause && playerctl status")
  awful.spawn.easy_async_with_shell(cmd, function(stdout)
    if (stdout == "Playing\n") then
      osd.text {
        screen = awful.screen.focused(),
        text = "mpris unpaused"
      }
    else
      osd.text {
        screen = awful.screen.focused(),
        text = "mpris paused"
      }
    end
    mpris:update_workers{}
  end)
end

function _M.step_volume(step)
  local vol = tonumber(mpris.state["mpris:volume"])+step
  if (vol >= 1) then
    vol = 1
  elseif (vol <= 0) then
    vol = 0
  end

  local cmd = string.format("playerctl volume %s", string.format("%.2f", vol))
  awful.spawn.easy_async_with_shell(cmd, function(_,_,_,exit_code) 
    if (exit_code == 0) then 
      osd.text {
        screen = awful.screen.focused(),
        text = string.format("mpris vol: %.0f%%", vol*100),
      }
      mpris:update_workers{}
    end
  end)
end

return _M
