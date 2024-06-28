local awful   = require('awful')
local gears   = require('gears')

local keys = require('config.globals').keys
local mod  = keys.mod
local alt  = keys.alt

local wwmfact = 0.025
local hwmfact = 0.05

local binds = gears.table.join(
  awful.key({ mod, }, "r", function() awful.layout.inc(1) end,
    {description = "select next layout", group = "layout"}
  ),
  awful.key({ mod, "Shift"}, "r", function() awful.layout.inc(-1) end,
    {description = "select previous layout", group = "layout"}
  ),
  awful.key({ mod, "Control" }, "l", function() awful.tag.incmwfact(-wwmfact) end,
    {description = "decrease mater window width factor", group = "layout"}
  ),
  awful.key({ mod, "Control" }, "h", function() awful.tag.incmwfact(wwmfact) end,
    {description = "increase master window width factor", group = "layout"}
  ),
  awful.key({ mod, "Control" }, "k", function() awful.client.incwfact(-hwmfact) end,
    {description = "decrease master window height factor", group = "layout"}
  ),
  awful.key({ mod, "Control" }, "j", function() awful.client.incwfact(hwmfact) end,
    {description = "increase master window height factor", group = "layout"}
  ),

  awful.key({ mod }, "l", function() awful.client.focus.bydirection("right", client.focused) end,
    {description = "focus the right window", group = "client"}
  ),
  awful.key({ mod }, "h", function() awful.client.focus.bydirection("left", client.focused) end,
    {description = "focus the left window", group = "client"}
  ),
  awful.key({ mod }, "k", function() awful.client.focus.bydirection("up", client.focused) end,
    {description = "focus the upper window", group = "client" }
  ),
  awful.key({ mod }, "j", function() awful.client.focus.bydirection("down", client.focused) end,
    {description = "focus the bottom window", group = "client"}
  ),

  awful.key({ mod, "Shift" }, "l", function() awful.client.swap.bydirection("right", client.focus) end,
    {description = "swap with the right window", group = "client"}
  ),
  awful.key({ mod, "Shift" }, "h", function() awful.client.swap.bydirection("left", client.focus) end,
    {description = "swap with the left window", group = "client"}
  ),
  awful.key({ mod, "Shift" }, "j", function() awful.client.swap.bydirection("down", client.focus) end,
    {description = "swap with the bottom window", group = "client"}
  ),
  awful.key({ mod, "Shift" }, "k", function() awful.client.swap.bydirection("up", client.focus) end,
    {description = "swap with the upper window", group = "client"}
  ),

  awful.key({ mod }, "Tab", awful.tag.viewnext,
    {description = "change to next screen", group = "tag"}
  ),
  awful.key({ mod, "Control" }, "Tab", awful.tag.viewprev,
    {description = "change to previous screen", group = "tag"}
  ),
  awful.key({ mod, alt, "Control"}, "l", function() awful.screen.focus_relative(1) end,
    {description = "focus next screen", group = "tag"}
  ),
  awful.key({ mod, alt, "Control"}, "h", function() awful.screen.focus_relative(-1) end,
    {description = "focus previous screen", group = "tag"}
  ),

  awful.key({ mod, "Control" }, "m",
    function ()
      local c = awful.client.restore()
      if c then
        c:emit_signal("request::activate", "key.unminimize", {raise = true})
      end
    end,
    {description = "restore minimized", group = "client"}
  )
)

return binds
