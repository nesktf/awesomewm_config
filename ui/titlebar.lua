local awful = require('awful')
local wibox = require('wibox')

local ui_bindings = require('binding.ui')

local _M = {}

_M.attach_floating = function(client)
  local titlebar_top = awful.titlebar(client, {
    position = "top",
    size = 22,
  })
  titlebar_top:setup({
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
  })

  local titlebar_bottom = awful.titlebar(client, {
    position = "bottom",
    size = 4,
  })
  titlebar_bottom:setup({
    layout = wibox.layout.align.horizontal,
    widget = wibox.container.background,
  })
end

return _M
