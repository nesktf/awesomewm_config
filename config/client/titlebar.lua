local awful = require('awful')
local wibox = require('wibox')

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)

  local title_bar = awful.titlebar(c, {
    -- size = 22,
    -- bg_normal = "#303030"
  })

  -- buttons for the titlebar
  local buttons = {
    awful.button({ }, 1, function()
      c:activate { context = "titlebar", action = "mouse_move" }
    end),
    awful.button({ }, 3, function()
      c:activate { context = "titlebar", action = "mouse_resize" }
    end)
  }

  title_bar.widget = {
    { -- Left
      awful.titlebar.widget.stickybutton   (c),
      awful.titlebar.widget.ontopbutton    (c),
      awful.titlebar.widget.floatingbutton (c),
      {
        awful.titlebar.widget.titlewidget(c),
        layout  = wibox.layout.fixed.horizontal,
      },
      layout  = wibox.layout.fixed.horizontal
    },
    { -- Middle
      -- { -- Title
      --     align  = "center",
      --     widget = awful.titlebar.widget.titlewidget(c)
      -- },
      buttons = buttons,
      layout  = wibox.layout.flex.horizontal
    },
    { -- Right
      awful.titlebar.widget.minimizebutton(c),
      awful.titlebar.widget.maximizedbutton(c),
      awful.titlebar.widget.closebutton    (c),
      layout = wibox.layout.fixed.horizontal()
    },
    layout = wibox.layout.align.horizontal
  }
end)


