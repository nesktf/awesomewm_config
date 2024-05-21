local awful = require('awful')
local wibox = require('wibox')

local client_bindings = require('config.bindings.client')

return function(c)
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
end
