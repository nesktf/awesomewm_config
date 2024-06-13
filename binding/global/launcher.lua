local awful   = require('awful')
local gears   = require('gears')
local menubar = require("menubar")

local keys    = require('main.globals').keys
local modkey  = keys.mod
local altkey  = keys.alt

local apps    = require('main.globals').app
local picom   = require('config.picom')

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
      awful.spawn(apps.terminal)
    end,
    {description = "open a terminal", group = "launcher"}
  ),
  awful.key({ modkey }, "space",
    function()
      awful.spawn(apps.launcher)
    end,
    {description = "open launcher", group = "launcher"}
  ),
  awful.key({ "Control", altkey }, "f",
    function ()
      awful.spawn(apps.browser)
    end,
    {description = "open browser", group = "launcher"}
  ),
  awful.key({ "Control", altkey }, "w",
    function ()
      awful.spawn(apps.browser_w)
    end,
    {description = "open work browser", group = "launcher"}
  ),
  awful.key({ "Control", altkey }, "g",
    function ()
      awful.spawn(apps.game_launcher)
    end,
    {description = "open game launcher", group = "launcher"}
  ),
  awful.key({ "Control", altkey }, "r",
    function ()
      awful.spawn(apps.file_manager)
    end,
    {description = "open file manager", group = "launcher"}
  ),
  awful.key({ "Control", altkey }, "y",
    function()
      awful.spawn(apps.yt_viewer)
    end,
    {description = "open yt viewer", group = "launcher"}
  ),
  awful.key({ "Control", altkey}, "d",
    function()
      awful.spawn(apps.dev_launcher)
    end,
    {description = "open dev launcher", group = "launcher"}
  ),
  awful.key({ "Control", altkey }, "p",
    function()
      picom.toggle_picom()
    end,
  {description = "toggle compositor", group = "launcher"}
  )
)

  return launcher_bindings
