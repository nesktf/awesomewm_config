local awful = require('awful')
local gears = require('gears')

local mod = require('config.bindings.mod')
local modkey = mod.mod_key
local altkey = mod.alt_key

local client_bindings = {}

client_bindings.titlebar_buttons = function(c)
  return gears.table.join(
    awful.button({ }, 1, function()
      c:emit_signal("request::activate", "titlebar", {raise = true})
      awful.mouse.client.move(c)
    end),
    awful.button({ }, 3, function()
      c:emit_signal("request::activate", "titlebar", {raise = true})
      awful.mouse.client.resize(c)
    end)
  )
end

client_bindings.buttons = gears.table.join( -- Mouse bindings
  awful.button({ }, 1, function (c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
  end),
  awful.button({ modkey }, 1, function (c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
    awful.mouse.client.move(c)
  end),
  awful.button({ modkey }, 3, function (c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
    awful.mouse.client.resize(c)
  end)
)

client_bindings.keys = gears.table.join(
  awful.key({ modkey, "Shift" }, "f",
    function (c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end,
    {description = "toggle fullscreen", group = "client"}
  ),
  awful.key({ "Control", altkey }, "q",
    function (c)
      c:kill()
    end,
    {description = "close window", group = "client"}
  ),
  awful.key({ modkey }, "f", awful.client.floating.toggle,
    {description = "toggle floating", group = "client"}
  ),
  awful.key({ modkey }, "m",
    function (c)
      c.minimized = true
    end,
    {description = "minimize", group = "client"}
  ),
  awful.key({ modkey }, "a",
    function (c)
      local tb = awful.titlebar

      if (not c.maximized) then
        tb.hide(c)
      elseif(c.floating) then
        tb.show(c)
      end

      c.maximized = not c.maximized
      c:raise()
    end,
    {description = "(un)maximize", group = "client"}
  ),
  awful.key({ modkey }, "t",
    function (c)
      c.ontop = not c.ontop
    end,
    {description = "toggle keep on top", group = "client"}
  ),
  awful.key({ modkey }, "x",
    function(c)
      awful.titlebar.toggle(c)
    end,
    {description = "toggle window borders", group = "client"}
  )
)

return client_bindings
