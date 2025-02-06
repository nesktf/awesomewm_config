local awful   = require('awful')
local gears   = require('gears')
local menubar = require("menubar")
local popup   = require("awful.hotkeys_popup")

local cgkeys = require('config.globals').keys
local mod  = cgkeys.mod
local alt  = cgkeys.alt

local switcher = require("widget.switcher")
local sound    = require("widget.sound")

local launcher  = require('config.launcher')
local script    = require('config.script')
local picom     = require('config.picom')

local media_keys = gears.table.join(
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
      sound.toggle_sink_mute()
    end,
    {description = "toggle mute volume", group = "media"}
  ),

  awful.key({ mod }, "F4",
    function()
      sound.set_balance(1.5909)
    end,
    {description = "reset volume", group = "media"}
  ),
  awful.key({ mod }, "F5",
    function()
      sound.set_balance(1)
    end,
    {description = "balance", group = "media"}
  ),
  awful.key({ mod }, "c",
    function()
      sound.toggle_source_mute()
    end,
    {description = "toggle mute microphone", group = "media"}
  )
)

local wwmfact = 0.025
local hwmfact = 0.05
local layout_keys = gears.table.join(
  awful.key({ mod, }, "r",
    function() awful.layout.inc(1) end,
    {description = "select next layout", group = "layout"}
  ),
  awful.key({ mod, "Shift"}, "r",
    function() awful.layout.inc(-1) end,
    {description = "select previous layout", group = "layout"}
  ),
  awful.key({ mod, "Control" }, "l",
    function() awful.tag.incmwfact(-wwmfact) end,
    {description = "decrease mater window width factor", group = "layout"}
  ),
  awful.key({ mod, "Control" }, "h",
    function() awful.tag.incmwfact(wwmfact) end,
    {description = "increase master window width factor", group = "layout"}
  ),
  awful.key({ mod, "Control" }, "k",
    function() awful.client.incwfact(-hwmfact) end,
    {description = "decrease master window height factor", group = "layout"}
  ),
  awful.key({ mod, "Control" }, "j",
    function() awful.client.incwfact(hwmfact) end,
    {description = "increase master window height factor", group = "layout"}
  ),

  awful.key({ mod }, "l",
    function() awful.client.focus.bydirection("right", client.focused) end,
    {description = "focus the right window", group = "client"}
  ),
  awful.key({ mod }, "h",
    function() awful.client.focus.bydirection("left", client.focused) end,
    {description = "focus the left window", group = "client"}
  ),
  awful.key({ mod }, "k",
    function() awful.client.focus.bydirection("up", client.focused) end,
    {description = "focus the upper window", group = "client" }
  ),
  awful.key({ mod }, "j",
    function() awful.client.focus.bydirection("down", client.focused) end,
    {description = "focus the bottom window", group = "client"}
  ),

  awful.key({ mod, "Shift" }, "l",
    function() awful.client.swap.bydirection("right", client.focus) end,
    {description = "swap with the right window", group = "client"}
  ),
  awful.key({ mod, "Shift" }, "h",
    function() awful.client.swap.bydirection("left", client.focus) end,
    {description = "swap with the left window", group = "client"}
  ),
  awful.key({ mod, "Shift" }, "j",
    function() awful.client.swap.bydirection("down", client.focus) end,
    {description = "swap with the bottom window", group = "client"}
  ),
  awful.key({ mod, "Shift" }, "k",
    function() awful.client.swap.bydirection("up", client.focus) end,
    {description = "swap with the upper window", group = "client"}
  ),

  awful.key({ mod }, "Tab",
    awful.tag.viewnext,
    {description = "change to next screen", group = "tag"}
  ),
  awful.key({ mod, "Control" }, "Tab",
    awful.tag.viewprev,
    {description = "change to previous screen", group = "tag"}
  ),
  awful.key({ mod, alt, "Control"}, "l",
    function() awful.screen.focus_relative(1) end,
    {description = "focus next screen", group = "tag"}
  ),
  awful.key({ mod, alt, "Control"}, "h",
    function() awful.screen.focus_relative(-1) end,
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
  ),
  awful.key({ alt }, "Tab",
    function()
      switcher.switch(1)
    end,
    {description = "switch", group = "client"}
  )
)

local launcher_keys = gears.table.join(
   awful.key({ mod }, "p",
    function() menubar.show() end,
    {description = "show the menubar", group = "launcher"}
  ),
  awful.key({ "Control", alt }, "t",
    launcher.terminal,
    {description = "open a terminal", group = "launcher"}
  ),
  awful.key({ mod }, "space",
    launcher.rofi_drun,
    {description = "open launcher", group = "launcher"}
  ),
  awful.key({ "Control", alt }, "f",
    launcher.browser_main,
    {description = "open browser", group = "launcher"}
  ),
  awful.key({ "Control", alt }, "w",
    launcher.browser_work,
    {description = "open work browser", group = "launcher"}
  ),
  awful.key({ "Control", alt }, "g",
    launcher.lutris,
    {description = "open game launcher", group = "launcher"}
  ),
  awful.key({ "Control", alt }, "r",
    launcher.files,
    {description = "open file manager", group = "launcher"}
  ),
  awful.key({ "Control", alt }, "y",
    launcher.freetube,
    {description = "open yt viewer", group = "launcher"}
  ),
  awful.key({ "Control", alt }, "p",
    picom.toggle,
    {description = "toggle compositor", group = "launcher"}
  ),
  awful.key({ "Control", alt }, "u",
    script.toggle_crt,
    {description = "toggle crt", group = "launcher"}
  )
)

return {
  keys =  gears.table.join(
    awful.key({ mod }, "s",
      function() popup.show_help(nil, awful.screen.focused()) end,
      {description="show help", group="awesome"}
    ),
    awful.key({ mod, "Control" }, "r",
      awesome.restart,
      {description = "reload awesome", group = "awesome"}
    ),
    awful.key({ mod, "Control" }, "q",
      awesome.quit,
      {description = "quit awesome", group = "awesome"}
    ),

    awful.key({ mod, "Shift" }, "x",
      function ()
        local prompt = awful.screen.focused().panel:get_children_by_id("prompt")[1]
        awful.prompt.run {
          prompt       = "Run Lua code: ",
          textbox      = prompt,
          exe_callback = awful.util.eval,
          history_path = awful.util.get_cache_dir() .. "/history_eval"
        }
      end,
      {description = "lua execute prompt", group = "awesome"}
    ),
    awful.key({ mod, "Shift"}, "o",
      function()
        awful.screen.focused().panel:toggle_floating()
      end,
      {description = "togle floating panel", group = "awesome"}
    ),
    media_keys,
    layout_keys,
    launcher_keys
  ),

  buttons = gears.table.join(
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
  )
}
