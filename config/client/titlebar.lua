local awful = require('awful')
local wibox = require('wibox')

local client_bindings = require('config.bindings.client')

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
  -- title_bar.widget = {
  awful.titlebar(c) : setup {
    { -- Left
      awful.titlebar.widget.stickybutton   (c),
      awful.titlebar.widget.ontopbutton    (c),
      awful.titlebar.widget.floatingbutton (c),
      {
        awful.titlebar.widget.titlewidget(c),
        layout  = wibox.layout.fixed.horizontal,
      },
      -- buttons = buttons,
      layout  = wibox.layout.fixed.horizontal
    },
    { -- Middle
      -- { -- Title
      --     align  = "center",
      --     widget = awful.titlebar.widget.titlewidget(c)
      -- },
      buttons = client_bindings.titlebar_buttons(c),
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


