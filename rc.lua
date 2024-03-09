local awful = require("awful")
local beautiful = require("beautiful")
local menubar = require("menubar")
local naughty = require("naughty")

-- Error handling
naughty.connect_signal("request::display_error", function(message, startup)
  naughty.notification {
      urgency = "critical",
      title   = "Oops, an error happened"..(startup and " during startup!" or "!"),
      message = message
  }
end)

local awesome_dir = "~/.config/awesome"
local script_dir = awesome_dir .. "/util"
local terminal = "alacritty"

-- Theme init
beautiful.init(awesome_dir .. "/theme/theme.lua")

menubar.utils.terminal = terminal -- Set the terminal for applications that require it

require('layout')
require('config')

awful.spawn.with_shell(script_dir .. "/autorun.sh")



-- -- Signal function to execute when a new client appears.
-- client.connect_signal("manage", function (c)
--   -- Set the windows at the slave,
--   -- i.e. put it at the end of others instead of setting it master.
--   -- if not awesome.startup then awful.client.setslave(c) end
--
--   if awesome.startup
--     and not c.size_hints.user_position
--     and not c.size_hints.program_position then
--       -- Prevent clients from being unreachable after screen count changes.
--       awful.placement.no_offscreen(c)
--   end
--   c.shape = function(cr, w, h)
--     gears.shape.rounded_rect(cr, w, h, 4)
--   end
-- end)

-- client.connect_signal("property::maximized", function(c)
  -- c.border_width = c.maximized and 0 or beautiful.border_width
-- end)

--
-- client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
-- client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
