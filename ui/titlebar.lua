local awful = require('awful')
local wibox = require('wibox')

local ui_bindings = require('binding.ui')

local _M = {}

_M.attach_floating = function(client)
  awful.titlebar(client) : setup {
    { -- Left
      awful.titlebar.widget.stickybutton(client),
      awful.titlebar.widget.ontopbutton(client),
      awful.titlebar.widget.floatingbutton(client),
      {
        awful.titlebar.widget.titlewidget(client),
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
      buttons = ui_bindings.titlebar_buttons(client),
      layout  = wibox.layout.flex.horizontal
    },
    { -- Right
      awful.titlebar.widget.minimizebutton(client),
      awful.titlebar.widget.maximizedbutton(client),
      awful.titlebar.widget.closebutton(client),
      layout = wibox.layout.fixed.horizontal
    },
    layout = wibox.layout.align.horizontal
  }
end

return _M
