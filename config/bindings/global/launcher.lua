local awful   = require('awful')
local gears   = require('gears')
local menubar = require("menubar")

local keys    = require('config.const').keys
local modkey  = keys.mod
local altkey  = keys.alt

local apps    = require('config.apps')

local launcher_bindings = gears.table.join(
  -- Launchers
   awful.key({ modkey }, "p",
    function()
      menubar.show()
    end,
    {description = "show the menubar", group = "launcher"}
  ),
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
      awful.spawn(apps.list.file_manager)
    end,
    {description = "open file manager", group = "launcher"}
  ),
  awful.key({ "Control", altkey }, "y",
    function()
      awful.spawn(apps.list.yt_viewer)
    end,
    {description = "open yt viewer", group = "launcher"}
  ),
  awful.key({ "Control", altkey}, "d",
    function()
      awful.spawn(apps.list.dev_launcher)
    end,
    {description = "open dev launcher", group = "launcher"}
  )
)

return launcher_bindings
