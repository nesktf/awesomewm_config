local awful = require('awful')

local mod = require('config.bindings.mod')
local modkey = mod.mod_key
local altkey = mod.alt_key

local client_bindings = {}

client_bindings.mouse = awful.util.table.join(
  awful.button({ }, 1, function (c)
      c:activate { context = "mouse_click" }
  end),
  awful.button({ modkey }, 1, function (c)
      c:activate { context = "mouse_click", action = "mouse_move"  }
  end),
  awful.button({ modkey }, 3, function (c)
      c:activate { context = "mouse_click", action = "mouse_resize"}
  end)
)

client_bindings.keys = awful.util.table.join(
-- local clientkeys = gears.table.join(
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


