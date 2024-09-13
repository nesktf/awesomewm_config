local awful = require('awful')
local gears = require('gears')

local keys = require('config.globals').keys
local mod  = keys.mod
local alt  = keys.alt

local cutil = require('client.util')

local __client_buttons = gears.table.join( -- Mouse bindings
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

local __client_keys = gears.table.join(
  awful.key({ mod, "Shift" }, "f",
    cutil.toggle_fullscreen,
    {description = "toggle fullscreen", group = "client"}
  ),
  awful.key({ "Control", alt }, "q",
    function (c) c:kill() end,
    {description = "close window", group = "client"}
  ),
  awful.key({ mod }, "f", awful.client.floating.toggle,
    {description = "toggle floating", group = "client"}
  ),
  awful.key({ mod }, "m",
    function (c) c.minimized = true end,
    {description = "minimize", group = "client"}
  ),
  awful.key({ mod }, "a",
    cutil.toggle_maximized,
    {description = "(un)maximize", group = "client"}
  ),
  awful.key({ mod }, "t",
    function (c) c.ontop = not c.ontop end,
    {description = "toggle keep on top", group = "client"}
  ),
  awful.key({ mod }, "x",
    cutil.toggle_titlebars,
    {description = "toggle window borders", group = "client"}
  ),
  awful.key({ mod }, "z",
    cutil.toggle_tiling_borders,
    {description = "toggle tiling borders", group = "client"}
  ),
  awful.key({ mod, alt }, "l",
    function(c) c:move_to_screen(c.screen.index+1) end,
    {description = "move to next screen", group = "client"}
  ),
  awful.key({ mod, alt }, "h",
    function(c) c:move_to_screen(c.screen.index-1) end,
    {description = "move to previous screen", group = "client"}
  )
)

local _M = {}

function _M.keys()
  return __client_keys
end

function _M.buttons()
  return __client_buttons
end

return _M
