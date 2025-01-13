local awful     = require('awful')
local wibox     = require('wibox')
local gears     = require('gears')
local theme     = require('theme')

local _M = {}

function _M.toggle(c, toggle, floating)
  if (c.requests_no_titlebar) then
    return
  end

  if (not toggle) then
    awful.titlebar.hide(c, "top")
    awful.titlebar.hide(c, "bottom")
  elseif (floating) then
    awful.titlebar.show(c, "top")
    awful.titlebar.show(c, "bottom")
  end
end

function _M.setup(client)
  assert(client ~= nil)

  local titlebar = {
    top = awful.titlebar(client, {
      position = "top",
      size     = theme.titlebar_top_size,
    }),
    bottom = awful.titlebar(client, {
      position = "bottom",
      size     = theme.titlebar_bot_size,
    }),
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
          awful.mouse.c.resize(client)
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
end

return _M
