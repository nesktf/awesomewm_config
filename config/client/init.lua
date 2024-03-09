local awful = require('awful')
local wibox = require('wibox')
local naughty = require('naughty')
local ruled = require('ruled')



-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
  -- buttons for the titlebar
  local buttons = {
    awful.button({ }, 1, function()
      c:activate { context = "titlebar", action = "mouse_move" }
    end),
    awful.button({ }, 3, function()
      c:activate { context = "titlebar", action = "mouse_resize" }
    end)
  }
  -- local buttons = gears.table.join(
  --     awful.button({ }, 1, function()
  --         c:emit_signal("request::activate", "titlebar", {raise = true})
  --         awful.mouse.client.move(c)
  --     end),
  --     awful.button({ }, 3, function()
  --         c:emit_signal("request::activate", "titlebar", {raise = true})
  --         awful.mouse.client.resize(c)
  --     end)
  -- )


  awful.titlebar(c).widget = {
    { -- Left
        awful.titlebar.widget.iconwidget(c),
        buttons = buttons,
        layout  = wibox.layout.fixed.horizontal
    },
    { -- Middle
        { -- Title
            align  = "center",
            widget = awful.titlebar.widget.titlewidget(c)
        },
        buttons = buttons,
        layout  = wibox.layout.flex.horizontal
    },
    { -- Right
        awful.titlebar.widget.floatingbutton (c),
        awful.titlebar.widget.maximizedbutton(c),
        awful.titlebar.widget.stickybutton   (c),
        awful.titlebar.widget.ontopbutton    (c),
        awful.titlebar.widget.closebutton    (c),
        layout = wibox.layout.fixed.horizontal()
    },
    layout = wibox.layout.align.horizontal
  }
end)

ruled.notification.connect_signal("request::rules", function()
  --- Rules for all notifications
  ruled.notification.append_rule {
    rule = {},
    properties = {
      screen = awful.screen.preferred,
      implicit_timeout = 5
    }
  }
end)

naughty.connect_signal("request::display", function(n)
  naughty.layout.box { notification = n }
end)


-- client.connect_signal("property::floating", function(c)
--   local tb = awful.titlebar
--   if (c.floating and not c.maximized) then tb.show(c) else tb.hide(c) end
-- end)
--
-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

