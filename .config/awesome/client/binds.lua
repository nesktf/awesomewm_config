local awful = require('awful')
local gears = require('gears')
local theme = require("theme")
local util  = require('client.util')

local keys = require('config.globals').keys
local mod  = keys.mod
local alt  = keys.alt

return {
  buttons = gears.table.join(
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
  ),

  keys = gears.table.join(
    awful.key({ mod, "Shift" }, "f",
      util.toggle_fullscreen,
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
      util.toggle_maximize,
      {description = "(un)maximize", group = "client"}
    ),
    awful.key({ mod }, "t",
      function (c) c.ontop = not c.ontop end,
      {description = "toggle keep on top", group = "client"}
    ),
    awful.key({ mod }, "x",
      util.toggle_titlebar,
      {description = "toggle window borders", group = "client"}
    ),
    awful.key({ mod }, "z",
      util.toggle_borders,
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
  ),
}
