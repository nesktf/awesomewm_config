local naughty = require('naughty')
local awful = require('awful')
-- local gears = require('gears')

require('config.client.titlebar')
require('config.client.rules')

naughty.connect_signal("request::display", function(n)
  naughty.layout.box { notification = n }
end)

client.connect_signal("property::floating", function(c)
  local tb = awful.titlebar
  if (c.floating and not c.maximized) then tb.show(c) else tb.hide(c) end
end)

-- Enable sloppy focus, so that focus follows mouse.
-- client.connect_signal("mouse::enter", function(c)
--   c:emit_signal("request::activate", "mouse_enter", {raise = false})
-- end)

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
