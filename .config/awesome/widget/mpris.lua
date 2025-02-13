local awful     = require("awful")
local wibox     = require("wibox")
local gears     = require("gears")

local osd = require('widget.osd')
local theme = require("theme")

local function parse_query(tbl, cmd_output)
  for line in cmd_output:gmatch("[^\n]+") do
    local it = line:gmatch("[^;]+")
    local k = it()
    local v = it()

    if (k == "au") then
      v = v:match("file://(.*)")
    end

    tbl[k] = v

    if (v == "-") then
      return
    end
  end
end

local state_format = string.format([[
au;{{default(mpris:artUrl, "file://%s")}}
ln;{{default(duration(mpris:length), "-")}}
st;{{status}}
po;{{duration(position)}}
tr;{{default(title, "Unknown Track")}}
al;{{default(album, "Unknown Album")}}
ar;{{default(xesam:artist, "Unknown Artist")}}
ge;{{default(xesam:genre, "Unknown Genre")}}]], theme.mpris_default_icon)

local state = {
  timer = nil,
  wibox = wibox {
    width = 512,
    height = 256,
    ontop = true,
    visible = false,
    bg = theme.titlebar_bg_focus,
  },
  worker_list = {},
  player_state = { ln = "-" },

  update = function(self)
    awful.spawn.easy_async_with_shell(
      string.format("playerctl -p mpd -f '%s' metadata", state_format),
      function(stdout, _, _, exit_code)
        if (exit_code ~= 0) then
          self.player_state.ln = "-"
        end
        parse_query(self.player_state, stdout)
        for _, worker in pairs(self.worker_list) do
          if (self.player_state.ln == "-") then
            worker:set_markup_silently("Nothing playing")
          else
            worker:set_markup_silently(theme.util.markdown_fg_focus(
              string.format("%s - %s", self.player_state.tr, self.player_state.ar)))
          end
        end
      end
    )
  end,

  init = function(self)
    self.timer = gears.timer {
      timeout = 2,
      autostart = true,
      callback = function() self:update() end
    }
  end,

  show_menu = function(self, screen, flag)
    if (not flag) then
      self.wibox.visible = false
      return
    end

    local widget = wibox.widget {
      layout = wibox.layout.fixed.horizontal,
      {
        widget = wibox.container.margin,
        margins = 5,
        {
          widget = wibox.widget.imagebox,
          image = self.player_state.au
        }
      },
      {
        widget = wibox.container.margin,
        margins = 5,
        {
          layout = wibox.layout.fixed.vertical,
          {
            widget = wibox.widget.textbox,
            text = string.format("Track: %s", self.player_state.tr)
          },
          {
            widget = wibox.widget.textbox,
            text = string.format("Album: %s", self.player_state.al)
          },
          {
            widget = wibox.widget.textbox,
            text = string.format("Artist: %s", self.player_state.ar)
          },
          {
            widget = wibox.widget.textbox,
            text = string.format("Genre: %s", self.player_state.ge)
          },
          {
            widget = wibox.widget.textbox,
            text = string.format("%s / %s", self.player_state.po, self.player_state.ln)
          }
        }
      }
    }
    self.wibox:geometry{
      x = screen.geometry.x + (screen.geometry.width - 500),
      y = screen.geometry.y + (screen.geometry.height - 500),
    }
    self.wibox:set_widget(widget)
    self.wibox.visible = true
  end
}

return setmetatable({
  new = function(screen)
    if (state.timer == nil) then
      state:init()
    end

    local widget = wibox.widget {
      widget = wibox.widget.textbox,
      align = "center",
      valign = "center",
      text = "Nothing playing",
    }
    widget:buttons(gears.table.join(
      awful.button({}, 1, nil, function()
        state:show_menu(screen, true)
      end),
      awful.button({}, 3, nil, function()
        state:show_menu(screen, false)
      end)
    ))

    table.insert(state.worker_list, widget)
    -- require("naughty").notify{text=tostring(#state.worker_list)}

    return widget
  end,
  -- toggle_pause = function()
  --   local cmd = string.format("playerctl play-pause && playerctl status")
  --   awful.spawn.easy_async_with_shell(cmd, function(stdout)
  --     if (stdout == "Playing\n") then
  --       osd.text {
  --         screen = awful.screen.focused(),
  --         text = "mpris unpaused"
  --       }
  --     else
  --       osd.text {
  --         screen = awful.screen.focused(),
  --         text = "mpris paused"
  --       }
  --     end
  --     state:update_workers{}
  --   end)
  -- end,
  --
  -- step_volume = function(step)
  --   local vol = tonumber(state.state["mpris:volume"])+step
  --   if (vol >= 1) then
  --     vol = 1
  --   elseif (vol <= 0) then
  --     vol = 0
  --   end
  --
  --   local cmd = string.format("playerctl volume %s", string.format("%.2f", vol))
  --   awful.spawn.easy_async_with_shell(cmd, function(_,_,_,exit_code) 
  --     if (exit_code == 0) then 
  --       osd.text {
  --         screen = awful.screen.focused(),
  --         text = string.format("mpris vol: %.0f%%", vol*100),
  --       }
  --       state:update_workers{}
  --     end
  --   end)
  -- end,
}, { __call = function(self, ...) return self.new(...) end })
