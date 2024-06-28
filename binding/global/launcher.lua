local awful   = require('awful')
local gears   = require('gears')
local menubar = require("menubar")

local launcher  = require('config.launcher')
local script    = require('config.script')
local picom     = require('config.picom')

local keys = require('config.globals').keys
local mod  = keys.mod
local alt  = keys.alt

local binds = gears.table.join(
   awful.key({ mod }, "p", function() menubar.show() end,
    {description = "show the menubar", group = "launcher"}
  ),
  awful.key({ "Control", alt }, "t", launcher.terminal,
    {description = "open a terminal", group = "launcher"}
  ),
  awful.key({ mod }, "space", launcher.rofi_drun,
    {description = "open launcher", group = "launcher"}
  ),
  awful.key({ "Control", alt }, "f", launcher.browser_main,
    {description = "open browser", group = "launcher"}
  ),
  awful.key({ "Control", alt }, "w", launcher.browser_work,
    {description = "open work browser", group = "launcher"}
  ),
  awful.key({ "Control", alt }, "g", launcher.lutris,
    {description = "open game launcher", group = "launcher"}
  ),
  awful.key({ "Control", alt }, "r", launcher.files,
    {description = "open file manager", group = "launcher"}
  ),
  awful.key({ "Control", alt }, "y", launcher.freetube,
    {description = "open yt viewer", group = "launcher"}
  ),
  awful.key({ "Control", alt }, "p", picom.toggle_picom,
    {description = "toggle compositor", group = "launcher"}
  ),
  awful.key({ "Control", alt }, "u", script.toggle_crt,
    {description = "toggle crt", group = "launcher"}
  )
)

return binds
