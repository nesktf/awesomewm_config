local awful = require('awful')
local gears = require('gears')

local modkey  = require('main.globals').keys.mod

local _M = {}

_M.titlebar_buttons = function(client)
  local buttons = gears.table.join(
    awful.button({ }, 1, function()
      client:emit_signal("request::activate", "titlebar", {raise = true})
      awful.mouse.client.move(client)
    end),
    awful.button({ }, 3, function()
      client:emit_signal("request::activate", "titlebar", {raise = true})
      awful.mouse.client.resize(client)
    end)
  )
  return buttons
end

_M.taglist_buttons = gears.table.join(
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

_M.tasklist_buttons = gears.table.join(
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
)

_M.layoutbox_buttons = gears.table.join(
  awful.button({ }, 1, function () awful.layout.inc( 1) end),
  awful.button({ }, 3, function () awful.layout.inc(-1) end),
  awful.button({ }, 4, function () awful.layout.inc( 1) end),
  awful.button({ }, 5, function () awful.layout.inc(-1) end)
)

return _M
