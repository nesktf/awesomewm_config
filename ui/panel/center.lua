local awful = require('awful')
local wibox = require('wibox')

local function build_center(screen, taskbut)
  local widget = awful.widget.tasklist {
    screen  = screen,
    filter  = awful.widget.tasklist.filter.currenttags,
    buttons = taskbut,
    widget_template = {
      id            = "background_role",
      widget        = wibox.container.background,
      forced_width  = 200,
      {
        widget  = wibox.container.margin,
        left    = 0,
        right   = 10,
        {
          layout = wibox.layout.fixed.horizontal,
          {
            widget  = wibox.container.margin,
            margins = 2,
            {
              id     = "icon_role",
              widget = wibox.widget.imagebox,
            },
          },
          {
            id     = "text_role",
            widget = wibox.widget.textbox,
          },
        },
      },
    },
    layout = {
      layout  = wibox.layout.fixed.horizontal,
      spacing = 1,
      spacing_widget = {
        {
          forced_width  = 5,
          forced_height = 24,
          thickness     = 1,
          color         = "#777777",
          widget        = wibox.widget.separator
        },
        valign = "center",
        halign = "center",
        widget = wibox.container.place,
      }, 
    },
  }
  return widget
end

return build_center
