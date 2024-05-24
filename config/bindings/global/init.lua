local awful   = require('awful')
local gears   = require('gears')

local modkey  = require('config.const').keys.mod

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")

local global_bindings = {}
global_bindings.mouse = gears.table.join(
  awful.button({ }, 4, awful.tag.viewnext),
  awful.button({ }, 5, awful.tag.viewprev)
)
global_bindings.keys = gears.table.join(
  -- AwesomeWM bindings
  awful.key({ modkey }, "s",
    function()
      hotkeys_popup.show_help(nil, awful.screen.focused())
    end,
    {description="show help", group="awesome"}
  ),
  awful.key({ modkey, "Control" }, "r", awesome.restart,
    {description = "reload awesome", group = "awesome"}
  ),
  awful.key({ modkey, "Control" }, "q", awesome.quit,
    {description = "quit awesome", group = "awesome"}
  ),
  awful.key({ modkey, "Shift" }, "x",
    function ()
      awful.prompt.run {
        prompt       = "Run Lua code: ",
        textbox      = awful.screen.focused().mypromptbox.widget,
        exe_callback = awful.util.eval,
        history_path = awful.util.get_cache_dir() .. "/history_eval"
      }
    end,
    {description = "lua execute prompt", group = "awesome"}
  )
)

-- External key bindings
local tag_bind = require('config.bindings.global.tag')
local media_bind = require('config.bindings.global.media')
local layout_bind = require('config.bindings.global.layout')
local launcher_bind = require('config.bindings.global.launcher')

global_bindings.keys = gears.table.join(global_bindings.keys,
  tag_bind,
  media_bind,
  layout_bind,
  launcher_bind
)

return global_bindings
