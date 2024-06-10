local awful   = require('awful')
local gears   = require('gears')

local mod     = require('main.globals').keys.mod
local popup   = require("awful.hotkeys_popup")

local tag_bind      = require('binding.global.tag')
local media_bind    = require('binding.global.media')
local layout_bind   = require('binding.global.layout')
local launcher_bind = require('binding.global.launcher')

local _M = {}

_M.buttons = gears.table.join(
  awful.button({ }, 4, awful.tag.viewnext),
  awful.button({ }, 5, awful.tag.viewprev)
)

_M.keys = gears.table.join(
  -- AwesomeWM bindings
  awful.key({ mod }, "s",
    function()
      popup.show_help(nil, awful.screen.focused())
    end,
    {description="show help", group="awesome"}
  ),
  awful.key({ mod, "Control" }, "r", awesome.restart,
    {description = "reload awesome", group = "awesome"}
  ),
  awful.key({ mod, "Control" }, "q", awesome.quit,
    {description = "quit awesome", group = "awesome"}
  ),
  awful.key({ mod, "Shift" }, "x",
    function ()
      awful.prompt.run {
        prompt       = "Run Lua code: ",
        textbox      = awful.screen.focused().mypromptbox.widget,
        exe_callback = awful.util.eval,
        history_path = awful.util.get_cache_dir() .. "/history_eval"
      }
    end,
    {description = "lua execute prompt", group = "awesome"}
  ),

  -- Extra bindings
  tag_bind,
  media_bind,
  layout_bind,
  launcher_bind
)

return _M
