local awful = require('awful')
local naughty = require('naughty')
local menubar = require("menubar")

require("awful.autofocus")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")

local mod = require('config.bindings.mod')
local modkey = mod.mod_key
local altkey = mod.alt_key

local terminal = "alacritty"

local global_bindings = {}

global_bindings.mouse = awful.util.table.join(
  awful.button({ }, 4, awful.tag.viewnext),
  awful.button({ }, 5, awful.tag.viewprev)
)

global_bindings.keys = awful.util.table.join(
  -- Awesome hotkeys
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
  ),

  awful.key({ modkey }, "F1",
    function()
      awful.spawn.with_shell("pactl set-sink-volume @DEFAULT_SINK@ -1.328252939dB")
    end,
    {description = "lower volume", group = "media"}
  ),

  awful.key({ modkey }, "F2",
    function()
      awful.spawn.with_shell("pactl set-sink-volume @DEFAULT_SINK@ +1.328252939dB")
    end,
    {description = "raise volume", group = "media"}
  ),


  awful.key({ modkey }, "F3",
    function()
      local command = "sleep 0.09 ; pactl list sinks | grep Volume | grep -oaE '..[0-9]%' | awk 'FNR == 1 {print}'"
      awful.spawn.easy_async_with_shell(command, function(out)
        naughty.notify({
          text = out,
          timeout = 1,
          position = "bottom_middle",
          replaces_id = 1,
          width = 500,
          height = 500
        })
      end)
      -- awful.spawn.with_shell("pactl set-sink-mute @DEFAULT_SINK@ toggle")
    end,
    {description = "toggle mute volume", group = "media"}
  ),

  awful.key({ modkey }, "F4",
    function()
      awful.spawn.with_shell("amixer -D pulse sset Master 100%,75%")
    end,
    {description = "reset volume", group = "media"}
  ),

  -- Screen manipulation
  awful.key({ modkey }, "Tab", awful.tag.viewnext,
    {description = "change to next screen", group = "tag"}
  ),
  awful.key({ modkey, "Control" }, "Tab", awful.tag.viewprev,
    {description = "change to previous screen", group = "tag"}
  ),

  -- Window focus
  awful.key({ modkey }, "l",
    function ()
      awful.client.focus.bydirection("right", client.focused)
    end,
    {description = "focus the right window", group = "client"}
  ),
  awful.key({ modkey }, "h",
    function ()
      awful.client.focus.bydirection("left", client.focused)
    end,
    {description = "focus the left window", group = "client"}
  ),
  awful.key({ modkey }, "k",
    function ()
      awful.client.focus.bydirection("up", client.focused)
    end,
    {description = "focus the upper window", group = "client" }
  ),
  awful.key({ modkey }, "j",
    function ()
      awful.client.focus.bydirection("down", client.focused)
    end,
    {description = "focus the bottom window", group = "client"}
  ),

  -- Window swap
  awful.key({ modkey, "Shift" }, "l",
    function ()
      awful.client.swap.bydirection("right", client.focus)
    end,
    {description = "swap with the right window", group = "client"}
  ),
  awful.key({ modkey, "Shift" }, "h",
    function ()
      awful.client.swap.bydirection("left", client.focus)
    end,
    {description = "swap with the left window", group = "client"}
  ),
  awful.key({ modkey, "Shift" }, "j",
    function ()
      awful.client.swap.bydirection("down", client.focus)
    end,
    {description = "swap with the bottom window", group = "client"}
  ),
  awful.key({ modkey, "Shift" }, "k",
    function ()
      awful.client.swap.bydirection("up", client.focus)
    end,
    {description = "swap with the upper window", group = "client"}
  ),


  -- Launchers
  awful.key({ "Control", altkey }, "t",
    function ()
      awful.spawn(terminal)
    end,
    {description = "open a terminal", group = "launcher"}
  ),
  awful.key({ modkey }, "space",
    function()
      awful.spawn("rofi -show drun")
    end,
    {description = "open rofi", group = "launcher"}
  ),
  awful.key({ "Control", altkey }, "f",
    function ()
      awful.spawn("librewolf")
    end,
    {description = "open librewolf", group = "launcher"}
  ),
  awful.key({ "Control", altkey }, "g",
    function ()
      awful.spawn("lutris")
    end,
    {description = "open lutris", group = "launcher"}
  ),
  awful.key({ "Control", altkey }, "r",
    function ()
      awful.spawn.with_shell("XDG_CURRENT_DESKTOP=KDE dolphin")
    end,
    {description = "open dolphin", group = "launcher"}
  ),
  awful.key({ "Control", altkey }, "m",
    function()
      awful.spawn('polymc -l "GT New Horizons"')
    end,
    {description = "open gtnh", group = "launcher"}
  ),
  awful.key({ modkey }, "p",
    function()
      menubar.show()
    end,
    {description = "show the menubar", group = "launcher"}
  ),
  awful.key({ modkey, "Shift" }, "p",
    function ()
      awful.screen.focused().mypromptbox:run()
    end,
    {description = "run prompt", group = "launcher"}
  ),

  -- Layout manipulation
  awful.key({ modkey, }, "r",
    function ()
      awful.layout.inc(1)
    end,
    {description = "select next layout", group = "layout"}
  ),
  awful.key({ modkey, "Shift"}, "r",
    function ()
      awful.layout.inc(-1)
    end,
    {description = "select previous layout", group = "layout"}
  ),
  awful.key({ modkey, "Control" }, "l",
    function ()
      awful.tag.incmwfact(-0.05)
    end,
    {description = "decrease mater window width factor", group = "layout"}
  ),
  awful.key({ modkey, "Control" }, "h",
    function ()
      awful.tag.incmwfact(0.05)
    end,
    {description = "increase master window width factor", group = "layout"}
  ),

  awful.key({ modkey, "Control" }, "m",
    function ()
      local c = awful.client.restore()
      if c then
        c:emit_signal(
          "request::activate", "key.unminimize", {rause = true}
        )
      end
    end,
    {description = "restore minimized", group = "client"}
  )
-- })

)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 4 do
  global_bindings.keys = awful.util.table.join(global_bindings.keys,
    -- View tag only.
    awful.key({ modkey }, "#" .. i + 9,
      function ()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
           tag:view_only()
        end
      end,
      {description = "view tag #"..i, group = "tag"}
    ),
    -- Toggle tag display.
    awful.key({ modkey, "Control" }, "#" .. i + 9,
      function ()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
           awful.tag.viewtoggle(tag)
        end
      end,
      {description = "toggle tag #" .. i, group = "tag"}
    ),
    -- Move client to tag.
    awful.key({ modkey, "Shift" }, "#" .. i + 9,
      function ()
          if client.focus then
              local tag = client.focus.screen.tags[i]
              if tag then
                  client.focus:move_to_tag(tag)
              end
         end
      end,
    {description = "move focused client to tag #"..i, group = "tag"}
    ),
    -- Toggle tag on focused client.
    awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
      function ()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
              client.focus:toggle_tag(tag)
          end
        end
      end,
      {description = "toggle focused client on tag #" .. i, group = "tag"}
    )
  )
end


return global_bindings
