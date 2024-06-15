local awful     = require('awful')
local wibox     = require('wibox')
local gears     = require('gears')
local beautiful = require('beautiful')

local _M = {}

local function __build_widget(args)
  assert(args.client ~= nil)
  local client = args.client

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
      layout  = wibox.layout.fixed.horizontal,
      awful.titlebar.widget.stickybutton(client),
      awful.titlebar.widget.ontopbutton(client),
      awful.titlebar.widget.floatingbutton(client),
      awful.titlebar.widget.titlewidget(client),
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
    },
    { -- Right
      layout = wibox.layout.fixed.horizontal,
      awful.titlebar.widget.minimizebutton(client),
      awful.titlebar.widget.maximizedbutton(client),
      awful.titlebar.widget.closebutton(client),
    },
  }

  titlebar.bottom:setup {
    widget = wibox.container.background,
  }

  return titlebar
end

return setmetatable(_M, { __call = function(_, ...) return __build_widget(...) end })
