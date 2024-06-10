local wibox = require('wibox') 
local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')
local screen = screen

local _M = {}

_M.root = wibox({
  widget = wibox.widget.systray(),
  width = 250,
  height = 250,
  ontop = true,
  visible = false,
  bg = beautiful.titlebar_bg_focus,
  shape = function(cr, w, h)
    gears.shape.rounded_rect(cr, w, h, 10)
  end
})

_M.show = function()
  local geom = screen[mouse.screen].geometry
  -- local h = _M.root.height
  local w = _M.root.width

  _M.root:geometry({
    x = geom.x + (geom.width - w) - 6,
    y = 24 + 6
  })
  _M.root.visible = not _M.root.visible
end

_M.button = function()
  local w = wibox.widget {
    {
      text = "dou",
      widget = wibox.widget.textbox
    },
    layout = wibox.layout.fixed.horizontal,
    buttons = gears.table.join(
      awful.button({}, 1, nil, function()
        _M.show()
      end)
    )
  }
  return w
end

return {show = _M.show, button = _M.button}
