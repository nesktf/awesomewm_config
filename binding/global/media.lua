local awful = require('awful')
local gears = require('gears')

local keys  = require('config.globals').keys
local mod   = keys.mod
local sound = require("widget.sound")

local media_bindings = gears.table.join(
  awful.key({ mod }, "F1",
    function()
      sound.step_volume(-0.05)
    end,
    {description = "lower volume", group = "media"}
  ),

  awful.key({ mod }, "F2",
    function()
      sound.step_volume(0.05)
    end,
    {description = "raise volume", group = "media"}
  ),

  awful.key({ mod }, "F3",
    function()
    end,
    {description = "toggle mute volume", group = "media"}
  ),

  awful.key({ mod }, "F4",
    function()
      sound.set_balance(1.4)
    end,
    {description = "reset volume", group = "media"}
  )
)

return media_bindings
