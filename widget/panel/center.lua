local awful = require('awful')
local gears = require('gears')
local wibox = require('wibox')
local beautiful = require('beautiful')

local function build_center(screen)
  local widget = awful.widget.tasklist {
    screen  = screen,
    filter  = awful.widget.tasklist.filter.currenttags,
    buttons = gears.table.join(
      awful.button({ }, 1, function (c)
        if c == client.focus then
          c.minimized = true
        else
          c:emit_signal("request::activate", "tasklist", {raise = true})
        end
      end),
      awful.button({ }, 3, function() awful.menu.client_list({ theme = { width = 250 } })end),
      awful.button({ }, 4, function() awful.client.focus.byidx(1) end),
      awful.button({ }, 5, function() awful.client.focus.byidx(-1) end)
    ),
    style = {
      bg_focus = "#00000000",
      bg_normal = "#00000000",
      bg_minimize = "#00000000",
      bg_image_normal = beautiful.tasklist_bg_image_normal,
      bg_image_minimize = beautiful.tasklist_bg_image_normal,
      bg_image_focus = beautiful.tasklist_bg_image_focus,
    },
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
      -- spacing_widget = {
      --   {
      --     forced_width  = 5,
      --     forced_height = 24,
      --     thickness     = 1,
      --     color         = "#777777",
      --     widget        = wibox.widget.separator
      --   },
      --   valign = "center",
      --   halign = "center",
      --   widget = wibox.container.place,
      -- }, 
    },
  }
  return widget
end

return build_center
