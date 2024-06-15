local awful = require('awful')
local wibox = require('wibox')

local function build_lhs(screen, layoutbut, tagbut)
  local layoutbox = awful.widget.layoutbox(screen)
  layoutbox:buttons(layoutbut)

  awful.tag({ "1", "2", "3", "4" }, screen, awful.layout.layouts[1])
  local taglist = awful.widget.taglist {
    screen  = screen,
    filter  = awful.widget.taglist.filter.all,
    buttons = tagbut
  }

  local widget = {
    layout          = wibox.layout.fixed.horizontal,
    spacing         = 12,
    spacing_widget  = wibox.widget.separator,
    wibox.widget.textclock(),
    {
      layout  = wibox.layout.fixed.horizontal,
      spacing = 8,
      taglist,
      layoutbox,
      {
        id      = "prompt",
        widget  = wibox.widget.textbox
      }
    },
  }
  return widget
end

return build_lhs
