local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')

local make_osd = function(text, icon)
  return awful.popup {
    widget = {
      {
        {
          text = text,
          widget = wibox.widget.textbox,
        },
        layout = wibox.layout.fixed.vertical,
      },
      margins = 10,
      widget = wibox.container.margin
    },
    -- border_color = '#AAAAAA',
    -- border_width = 1,
    -- shape = gears.shape.rounded_rect,
    placement = awful.placement.centered,
    ontop = true,
    visible = true,
  }
end

return function(text, icon, timeout)
  local popup = make_osd(text, icon)

  gears.timer.start_new(timeout, function()
    popup.visible = false
    return false
  end)
end
