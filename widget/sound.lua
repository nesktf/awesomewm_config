local awful     = require("awful")
local wibox     = require("wibox")
local gears     = require("gears")
local beautiful = require("beautiful")

local osd = require('widget.osd')

local alsa = {
  worker_list = {},
  balance = 1,
  timer = nil,
}
local alsa_range = 65536

local function vol_icon(_vol)
  if (_vol > .66) then
    return beautiful.volume_high
  elseif (_vol > .33) then
    return beautiful.volume_medium
  elseif (_vol > 0) then
    return beautiful.volume_low
  else
    return beautiful.volume_mute
  end
end

function alsa:init()
  self.timer = gears.timer {
    timeout = 2,
    autostart = true,
    callback = function() alsa:update_workers(false) end
  }
end

function alsa:update_workers(show_osd)
  local cmd = "pactl get-sink-volume @DEFAULT_SINK@ | awk 'NR==1{printf \"%s %s\", $5,$12}'" 
  awful.spawn.easy_async_with_shell(cmd, function(stdout)
    local channels = {}
    for str in string.gmatch(stdout, "[^%s]+") do
      table.insert(channels, str)
    end

    local vol = alsa.balance >= 1 and channels[1] or channels[2]
    local vol_value = 0.01*tonumber(vol:sub(1, -2))
    local image = vol_icon(vol_value)

    for _,worker in ipairs(self.worker_list) do
      if (worker.image ~= image) then
        worker.image = image
      end
    end

    if (show_osd) then
      osd.progress {
        screen = awful.screen.focused(),
        value = vol_value,
        icon = image
      }
    end
  end)
end

local _M = {}

function _M.new_worker(_)
  if (alsa.timer == nil and #alsa.worker_list == 0) then
    alsa:init()
  end

  local widget = wibox.widget {
    widget = wibox.widget.imagebox,
    image = beautiful.volume_high,
    resize = true,

    -- widget = wibox.widget.textbox,
    -- align = "center",
    -- valign = "center",
  }

  table.insert(alsa.worker_list, widget)
  alsa:update_workers()

  return widget
end

function _M.set_volume(vol) -- [0, 1]
  vol = vol/alsa.balance
  local new_vol = {math.floor(alsa_range*vol), math.floor(alsa_range*vol)}
  if (alsa.balance >= 1) then
    new_vol[1] = math.floor(new_vol[1]*alsa.balance)
  else
    new_vol[2] = math.floor(new_vol[2]*alsa.balance)
  end
  local cmd = string.format("pactl set-sink-volume @DEFAULT_SINK@ %s %s", new_vol[1], new_vol[2])

  awful.spawn.easy_async_with_shell(cmd, function()
    alsa:update_workers(true)
  end)
end

function _M.step_volume(step)
  local cmd = "pactl get-sink-volume @DEFAULT_SINK@ | awk 'NR==1{printf \"%s %s\", $3, $10}'"
  awful.spawn.easy_async_with_shell(cmd, function(stdout)
    local vol = {}
    for str in string.gmatch(stdout, "[^%s]+") do
      table.insert(vol, tonumber(str))
    end


    local val = step + (vol[1]/alsa_range)
    _M.set_volume(val <= 0 and 0 or val)
  end)
end

function _M.set_balance(bal)
  alsa.balance = bal
  _M.step_volume(0)
end

return _M
-- return setmetatable(_M, {__call = function(_,...) return new_worker(...) end})
