local awful = require('awful')
local gears = require('gears')
local wibox = require('wibox')
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi

local panel = function(s)
  -- local panel = wibox {
  --   ontop = true,
  --   screen = s,
  --   type = 'dock',
  --   height = dpi(24),
  --   width = s.geometry.width, x = s.geometry.x,
  --   y = s.geometry.y,
  --   stretch = false,
  --   bg = beautiful.background,
  --   fg = beautiful.fg_normal
  -- }
  local panel = awful.wibar({position = "top", screen = s})

  awful.tag({ "1", "2", "3", "4" }, s, awful.layout.layouts[1])

  s.taglist = awful.widget.taglist {
    screen = s,
    filter = awful.widget.taglist.filter.all,
    buttons = gears.table.join(
      awful.button({ }, 1, function(t) t:view_only() end),
      awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
      end),
      awful.button({ }, 3, awful.tag.viewtoggle),
      awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
      end),
      awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end),
      awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end)
    )
  }

  s.tasklist = awful.widget.tasklist {
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    buttons = gears.table.join(
      awful.button({ }, 1, function (c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal(
                "request::activate",
                "tasklist",
                {raise = true}
            )
        end
      end),
      awful.button({ }, 3, function() awful.menu.client_list({ theme = { width = 250 } })end),
      awful.button({ }, 4, function () awful.client.focus.byidx(1) end),
      awful.button({ }, 5, function () awful.client.focus.byidx(-1) end)
    ),
    layout = {
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
      spacing = 1,
      layout  = wibox.layout.fixed.horizontal
    },
    widget_template = {
      {
        {
          {
            {
              id     = "icon_role",
              widget = wibox.widget.imagebox,
            },
            margins = 2,
            widget  = wibox.container.margin,
          },
          layout = wibox.layout.fixed.horizontal,
          {
            id     = "text_role",
            widget = wibox.widget.textbox,
          },
        },
        left  = 0,
        right = 10,
        widget = wibox.container.margin
      },
      id     = "background_role",
      widget = wibox.container.background,
    }
  }

  s.layoutbox = awful.widget.layoutbox(s)
  s.layoutbox:buttons(gears.table.join(
    awful.button({ }, 1, function () awful.layout.inc( 1) end),
    awful.button({ }, 3, function () awful.layout.inc(-1) end),
    awful.button({ }, 4, function () awful.layout.inc( 1) end),
    awful.button({ }, 5, function () awful.layout.inc(-1) end)
  ))

  s.sensor_var = require('widget.sensor-bar')

  panel:setup {
    layout = wibox.layout.align.horizontal,
    {
      layout = wibox.layout.fixed.horizontal,
      spacing = 12,
      spacing_widget = {
        widget = wibox.widget.separator
      },
      wibox.widget.textclock(),
      s.taglist,
      awful.widget.prompt()
    },
    s.tasklist,
    {
      layout = wibox.layout.fixed.horizontal,
      spacing = 12,
      spacing_widget = {
        widget = wibox.widget.separator
      },
      s.sensor_var,
      {
        layout = wibox.layout.fixed.horizontal,
        spacing = 6,
        wibox.widget.systray(),
        s.layoutbox
      }
    }
  }

  return panel
end

return panel
