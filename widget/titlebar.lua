local awful     = require('awful')
local wibox     = require('wibox')
local gears     = require('gears')
local beautiful = require('beautiful')

local _M = {}

function _M.update_titlebars(c)
  local function is_floating()
    return (c.floating or (c.first_tag ~= nil and c.first_tag.layout.name == "floating"))
  end

  if (is_floating()) then
    awful.titlebar.show(c, "top")
    awful.titlebar.show(c, "bottom")
    c.border_width = beautiful.border_width
  else
    awful.titlebar.hide(c, "top")
    awful.titlebar.hide(c, "bottom")
    c.border_width = beautiful.border_width_tiling
  end
end

function _M.create(client)
  assert(client ~= nil)

  local titlebar = {
    top = awful.titlebar(client, {
      position = "top",
      size     = beautiful.titlebar_top_size,
    }),
    bottom = awful.titlebar(client, {
      position = "bottom",
      size     = beautiful.titlebar_bot_size,
    })
  }

  titlebar.top:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left
      widget = wibox.container.margin,
      top = 3, bottom = 3, left = 3, right = 5,
      {
        layout  = wibox.layout.fixed.horizontal,
        spacing = 4,
        awful.titlebar.widget.stickybutton(client),
        awful.titlebar.widget.ontopbutton(client),
        awful.titlebar.widget.floatingbutton(client),
      }
    },
    { -- Middle
      layout  = wibox.layout.flex.horizontal,
      buttons = gears.table.join(
        awful.button({ }, 1, function()
          client:emit_signal("request::activate", "titlebar", {raise = true})
          awful.mouse.client.move(client)
        end),
        awful.button({ }, 3, function()
          client:emit_signal("request::activate", "titlebar", {raise = true})
          awful.mouse.client.resize(client)
        end)
      ),
      awful.titlebar.widget.titlewidget(client),
    },
    { -- Right
      widget = wibox.container.margin,
      top = 3, bottom = 3, right = 3,
      {
        layout = wibox.layout.fixed.horizontal,
        spacing = 4,
        awful.titlebar.widget.minimizebutton(client),
        awful.titlebar.widget.maximizedbutton(client),
        awful.titlebar.widget.closebutton(client),
      } 
    },
  }

  titlebar.bottom:setup {
    widget = wibox.container.background,
  }

  return titlebar
end

return _M
