-- Standard awesome library
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")
local menubar = require("menubar")
local naughty = require("naughty")
local ruled = require("ruled")

local awful = require("awful")
require("awful.autofocus")

-- local battery_widget = require("awesome-wm-widgets.battery-widget.battery")
-- local volume_widget = require('widgets.volume-widget.volume')
-- local sensor_var = require("widgets.sensor-bar")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")


awesome.set_preferred_icon_size(128)

-- Error handling
naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification {
        urgency = "critical",
        title   = "Oops, an error happened"..(startup and " during startup!" or "!"),
        message = message
    }
end)

-- Theme init

-- Global Vars
local awesome_dir = "~/.config/awesome"
local script_dir = awesome_dir .. "/util"
local terminal = "alacritty"
modkey = "Mod4"
altkey = "Mod1"
-- local editor = os.getenv("EDITOR") or "nvim"
-- local editor_cmd = terminal .. " -e " .. editor
--
beautiful.init(awesome_dir .. "/theme/theme.lua")

-- Enabled Layouts
tag.connect_signal("request::default_layouts",
  function()
    awful.layout.append_default_layouts({
    awful.layout.suit.tile.left,
    awful.layout.suit.tile,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.floating,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
    })
  end
)


menubar.utils.terminal = terminal -- Set the terminal for applications that require it


require('layout')

screen.connect_signal("request::wallpaper", function(s)
    awful.wallpaper {
        screen = s,
        widget = {
            {
                image     = beautiful.wallpaper,
                upscale   = true,
                downscale = true,
                widget    = wibox.widget.imagebox,
            },
            valign = "center",
            halign = "center",
            tiled  = false,
            widget = wibox.container.tile,
        }
    }
end)

-- {{{ Mouse bindings
-- awful.mouse.append_global_mousebindings({
--
--  awful.button({ }, 3, function () mymainmenu:toggle() end),
    -- awful.button({ }, 4, awful.tag.viewprev),
    -- awful.button({ }, 5, awful.tag.viewnext),
-- })
-- }}}

-- local globalkeys = gears.table.join(
awful.keyboard.append_global_keybindings({
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

    -- awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
    --           {description = "increase master width factor", group = "layout"}),
    -- awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
    --           {description = "decrease master width factor", group = "layout"}),
    -- awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
    --           {description = "increase the number of master clients", group = "layout"}),
    -- awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
    --           {description = "decrease the number of master clients", group = "layout"}),
    -- awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
    --           {description = "increase the number of columns", group = "layout"}),
    -- awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
    --           {description = "decrease the number of columns", group = "layout"}),
})

client.connect_signal("request::default_keybindings", function()
  awful.keyboard.append_client_keybindings({

-- local clientkeys = gears.table.join(
  awful.key({ modkey, "Shift" }, "f",
    function (c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end,
    {description = "toggle fullscreen", group = "client"}
  ),
  awful.key({ "Control", altkey }, "q",
    function (c)
      c:kill()
    end,
    {description = "close window", group = "client"}
  ),
  awful.key({ modkey }, "f", awful.client.floating.toggle,
    {description = "toggle floating", group = "client"}
  ),
  awful.key({ modkey }, "m",
    function (c)
      c.minimized = true
    end,
    {description = "minimize", group = "client"}
  ),
  awful.key({ modkey }, "a",
    function (c)
      local tb = awful.titlebar

      if (not c.maximized) then
        tb.hide(c)
      elseif(c.floating) then
        tb.show(c)
      end

      c.maximized = not c.maximized
      c:raise()
    end,
    {description = "(un)maximize", group = "client"}
  ),
  awful.key({ modkey }, "t",
    function (c)
      c.ontop = not c.ontop
    end,
    {description = "toggle keep on top", group = "client"}
  ),
  awful.key({ modkey }, "x",
    function(c)
      awful.titlebar.toggle(c)
    end,
    {description = "toggle window borders", group = "client"}
  )
  -- awful.key({ modkey }, "q", function (c)
  --   c:emit_signal("request::activate", "mouse_click", {raise = true})
  --   if c.floating then awful.mouse.client.resize(c) end
  -- end,
  -- {description = "resize windows", group = "client"})

    -- awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
    --           {description = "move to master", group = "client"}),
    -- awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
    --           {description = "move to screen", group = "client"}),

  })
end)


-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
-- for i = 1, 4 do
--   globalkeys = gears.table.join(globalkeys,
--     -- View tag only.
--     awful.key({ modkey }, "#" .. i + 9,
--       function ()
--         local screen = awful.screen.focused()
--         local tag = screen.tags[i]
--         if tag then
--            tag:view_only()
--         end
--       end,
--       {description = "view tag #"..i, group = "tag"}
--     ),
--     -- Toggle tag display.
--     awful.key({ modkey, "Control" }, "#" .. i + 9,
--       function ()
--         local screen = awful.screen.focused()
--         local tag = screen.tags[i]
--         if tag then
--            awful.tag.viewtoggle(tag)
--         end
--       end,
--       {description = "toggle tag #" .. i, group = "tag"}
--     ),
--     -- Move client to tag.
--     awful.key({ modkey, "Shift" }, "#" .. i + 9,
--       function ()
--           if client.focus then
--               local tag = client.focus.screen.tags[i]
--               if tag then
--                   client.focus:move_to_tag(tag)
--               end
--          end
--       end,
--     {description = "move focused client to tag #"..i, group = "tag"}
--     ),
--     -- Toggle tag on focused client.
--     awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
--       function ()
--         if client.focus then
--           local tag = client.focus.screen.tags[i]
--           if tag then
--               client.focus:toggle_tag(tag)
--           end
--         end
--       end,
--       {description = "toggle focused client on tag #" .. i, group = "tag"}
--     )
--   )
-- end

-- local clientbuttons = gears.table.join(
--     awful.button({ }, 1, function (c)
--       c:emit_signal("request::activate", "mouse_click", {raise = true})
--     end),
--     awful.button({ modkey }, 1, function (c)
--       c:emit_signal("request::activate", "mouse_click", {raise = true})
--       awful.mouse.client.move(c)
--     end),
--     awful.button({ modkey }, 3, function (c)
--       c:emit_signal("request::activate", "mouse_click", {raise = true})
--       if c.floating then awful.mouse.client.resize(c) end
--       -- awful.mouse.client.resize(c)
--     end)
-- )

-- Set keys
-- root.keys(globalkeys)



-- Rules to apply to new clients (through the "manage" signal).
ruled.client.connect_signal("request::rules", function()
  ruled.client.append_rule {
    id = "global",
    rule = {},
    properties = {
      -- border_width = beautiful.border_width,
      -- border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      -- keys = clientkeys,
      -- buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap+awful.placement.no_offscreen
    }
  }
  ruled.client.append_rule {
    id = "floating",
    rule_any = {
      instance = {
        "DTA",  -- Firefox addon DownThemAll.
        "copyq",  -- Includes session name in class.
        "pinentry",
      },
      class = {
        "Arandr",
        "Blueman-manager",
        "Gpick",
        "Kruler",
        "MessageWin",  -- kalarm.
        "Sxiv",
        "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
        "Wpa_gui",
        "veromix",
        "xtightvncviewer",
        "xdg-desktop-portal-kde",
        "spectacle"
      },

      -- Note that the name property shown in xprop might be set slightly after creation of the client
      -- and the name shown there might not match defined rules here.
      name = {
        "Event Tester",  -- xev.
      },
      role = {
        "AlarmWindow",  -- Thunderbird's calendar.
        "ConfigManager",  -- Thunderbird's about:config.
        "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
      }
    },
    properties = {
      floating = true,
      placement = awful.placement.centered
    }
  }
  ruled.client.append_rule {
    id = "titlebars",
    rule_any = {
      type = { "normal", "dialog" },
      properties = { titlebars_enabled = true }
    }
  }
  ruled.client.append_rule {
   rule = {
      name = {
        "hydrus client media viewer"
      }
    },
    properties = {
      fullscreen = false,
      maximized = true,
      placement = awful.placement.centered
    }
  }
end)


-- -- Signal function to execute when a new client appears.
-- client.connect_signal("manage", function (c)
--   -- Set the windows at the slave,
--   -- i.e. put it at the end of others instead of setting it master.
--   -- if not awesome.startup then awful.client.setslave(c) end
--
--   if awesome.startup
--     and not c.size_hints.user_position
--     and not c.size_hints.program_position then
--       -- Prevent clients from being unreachable after screen count changes.
--       awful.placement.no_offscreen(c)
--   end
--   c.shape = function(cr, w, h)
--     gears.shape.rounded_rect(cr, w, h, 4)
--   end
-- end)

-- client.connect_signal("property::maximized", function(c)
  -- c.border_width = c.maximized and 0 or beautiful.border_width
-- end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
  -- buttons for the titlebar
  local buttons = {
    awful.button({ }, 1, function()
      c:activate { context = "titlebar", action = "mouse_move" }
    end),
    awful.button({ }, 3, function()
      c:activate { context = "titlebar", action = "mouse_resize" }
    end)
  }
  -- local buttons = gears.table.join(
  --     awful.button({ }, 1, function()
  --         c:emit_signal("request::activate", "titlebar", {raise = true})
  --         awful.mouse.client.move(c)
  --     end),
  --     awful.button({ }, 3, function()
  --         c:emit_signal("request::activate", "titlebar", {raise = true})
  --         awful.mouse.client.resize(c)
  --     end)
  -- )


  awful.titlebar(c).widget = {
    { -- Left
        awful.titlebar.widget.iconwidget(c),
        buttons = buttons,
        layout  = wibox.layout.fixed.horizontal
    },
    { -- Middle
        { -- Title
            align  = "center",
            widget = awful.titlebar.widget.titlewidget(c)
        },
        buttons = buttons,
        layout  = wibox.layout.flex.horizontal
    },
    { -- Right
        awful.titlebar.widget.floatingbutton (c),
        awful.titlebar.widget.maximizedbutton(c),
        awful.titlebar.widget.stickybutton   (c),
        awful.titlebar.widget.ontopbutton    (c),
        awful.titlebar.widget.closebutton    (c),
        layout = wibox.layout.fixed.horizontal()
    },
    layout = wibox.layout.align.horizontal
  }
end)

ruled.notification.connect_signal("request::rules", function()
  --- Rules for all notifications
  ruled.notification.append_rule {
    rule = {},
    properties = {
      screen = awful.screen.preferred,
      implicit_timeout = 5
    }
  }
end)

naughty.connect_signal("request::display", function(n)
  naughty.layout.box { notification = n }
end)


-- client.connect_signal("property::floating", function(c)
--   local tb = awful.titlebar
--   if (c.floating and not c.maximized) then tb.show(c) else tb.hide(c) end
-- end)
--
-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)
--
-- client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
-- client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

awful.spawn.with_shell(script_dir .. "/autorun.sh")
