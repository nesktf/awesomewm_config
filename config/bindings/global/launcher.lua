local awful = require('awful')
local menubar = require("menubar")
local apps = require('config.apps')
local mod = require('config.bindings.mod')
local modkey = mod.mod_key
local altkey = mod.alt_key

local launcher_bindings = awful.util.table.join(
  -- Launchers
  awful.key({ "Control", altkey }, "t",
    function ()
      awful.spawn(apps.list.terminal)
    end,
    {description = "open a terminal", group = "launcher"}
  ),
  awful.key({ modkey }, "space",
    function()
      awful.spawn(apps.list.launcher)
    end,
    {description = "open launcher", group = "launcher"}
  ),
  awful.key({ "Control", altkey }, "f",
    function ()
      awful.spawn(apps.list.browser)
    end,
    {description = "open browser", group = "launcher"}
  ),
  awful.key({ "Control", altkey }, "w",
    function ()
      awful.spawn(apps.list.browser_w)
    end,
    {description = "open work browser", group = "launcher"}
  ),
  awful.key({ "Control", altkey }, "g",
    function ()
      awful.spawn(apps.list.game_launcher)
    end,
    {description = "open game launcher", group = "launcher"}
  ),
  awful.key({ "Control", altkey }, "r",
    function ()
      awful.spawn.with_shell(apps.list.file_manager)
    end,
    {description = "open file manager", group = "launcher"}
  ),
  awful.key({ modkey }, "p",
    function()
      menubar.show()
    end,
    {description = "show the menubar", group = "launcher"}
  )
)

return launcher_bindings
