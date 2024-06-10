local awful   = require('awful')
local gears   = require('gears')

local keys  = require('main.globals').keys
local mod   = keys.mod
local alt   = keys.alt

local _M = {}

_M.buttons = gears.table.join( -- Mouse bindings
  awful.button({ }, 1, function (c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
  end),
  awful.button({ mod }, 1, function (c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
    awful.mouse.client.move(c)
  end),
  awful.button({ mod }, 3, function (c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
    awful.mouse.client.resize(c)
  end)
)

_M.keys = gears.table.join(
  awful.key({ mod, "Shift" }, "f",
    function (c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end,
    {description = "toggle fullscreen", group = "client"}
  ),
  awful.key({ "Control", alt }, "q",
    function (c)
      c:kill()
    end,
    {description = "close window", group = "client"}
  ),
  awful.key({ mod }, "f", awful.client.floating.toggle,
    {description = "toggle floating", group = "client"}
  ),
  awful.key({ mod }, "m",
    function (c)
      c.minimized = true
    end,
    {description = "minimize", group = "client"}
  ),
  awful.key({ mod }, "a",
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
  awful.key({ mod }, "t",
    function (c)
      c.ontop = not c.ontop
    end,
    {description = "toggle keep on top", group = "client"}
  ),
  awful.key({ mod }, "x",
    function(c)
      awful.titlebar.toggle(c)
    end,
    {description = "toggle window borders", group = "client"}
  )
)

return _M
