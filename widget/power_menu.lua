local awful     = require('awful')
local gears     = require('gears')
local wibox     = require('wibox')
local beautiful = require('beautiful')

local _M = {
  wibox = wibox{
    width = 200,
    height = 200,
    ontop = true,
    visible = false,
    bg = beautiful.titlebar_bg_focus,
    widget = wibox.widget {
      layout = wibox.layout.fixed.vertical,
      {
        widget = wibox.widget.textbox,
        text = "dou",
      }
    },
  },
}

_M.toggle_menu = function(args)
  assert(args.screen ~= nil)
  local screen = args.screen

  local geom = screen.geometry
  _M.wibox:geometry {
    x = geom.x + (geom.width - _M.wibox.width),
    y = geom.y + beautiful.panel_size
  }
  _M.wibox.visible = not _M.wibox.visible
end

_M.panel_widget = function(args)
  assert(args.screen ~= nil)

  local widget = wibox.widget {
    widget = wibox.container.background,
    buttons = gears.table.join(
      awful.button({}, 1, nil, function()
        _M.toggle_menu(args)
      end)
    ),
    {
      widget = wibox.widget.textbox,
      text = "dous",
    }
  }
  widget:connect_signal("mouse::enter", function()
    widget.bg = "#FF0000"
  end)
  widget:connect_signal("mouse::leave", function()
    widget.bg = beautiful.titlebar_bg_focus
  end)
  return widget
end

return _M
