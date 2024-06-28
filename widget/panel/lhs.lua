local awful = require('awful')
local gears = require('gears')
local wibox = require('wibox')

local mod = require('config.globals').keys.mod

local function build_lhs(screen)
  local layoutbox = awful.widget.layoutbox(screen)
  layoutbox:buttons(gears.table.join(
    awful.button({ }, 1, function() awful.layout.inc( 1) end),
    awful.button({ }, 3, function() awful.layout.inc(-1) end),
    awful.button({ }, 4, function() awful.layout.inc( 1) end),
    awful.button({ }, 5, function() awful.layout.inc(-1) end)
  ))

  local taglist = awful.widget.taglist {
    screen  = screen,
    filter  = awful.widget.taglist.filter.all,
    buttons = gears.table.join(
      awful.button({ }, 1, function(t) t:view_only() end),
      awful.button({ mod }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
      end),
      awful.button({ }, 3, awful.tag.viewtoggle),
      awful.button({ mod }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
      end),
      awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end),
      awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end)
    )
  }

  local widget = {
    layout          = wibox.layout.fixed.horizontal,
    spacing         = 6,
    -- spacing_widget  = wibox.widget.separator,
    wibox.widget.textclock(),
    {
      layout  = wibox.layout.fixed.horizontal,
      spacing = 8,
      taglist,
      layoutbox,
      {
        id      = "prompt",
        widget  = wibox.widget.textbox
      },
    },
    {
      widget = wibox.container.background,
    }
  }
  return widget
end

return build_lhs
