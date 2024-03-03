-- Standard awesome library
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")
local menubar = require("menubar")
local naughty = require("naughty")

local awful = require("awful")
require("awful.autofocus")

-- local battery_widget = require("awesome-wm-widgets.battery-widget.battery")
local volume_widget = require('widgets.volume-widget.volume')
local sensor_var = require("widgets.sensor-bar")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")


awesome.set_preferred_icon_size(128)

-- Error handling
if awesome.startup_errors then
  naughty.notify({
    preset = naughty.config.presets.critical,
    title = "Oops, there were errors during startup!",
    text = awesome.startup_errors
  })
end
do
  local in_error = false
  awesome.connect_signal("debug::error",
    function (err)
      -- Make sure we don't go into an endless error loop
      if in_error then return end
      in_error = true

      naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oops, an error happened!",
        text = tostring(err)
      })
      in_error = false
    end
  )
end

-- Theme init

-- Global Vars
local awesome_dir = "~/.config/awesome"
local script_dir = awesome_dir .. "/scripts"
local terminal = "konsole"
local modkey = "Mod4"
local altkey = "Mod1"
-- local editor = os.getenv("EDITOR") or "nvim"
-- local editor_cmd = terminal .. " -e " .. editor
--
beautiful.init(awesome_dir .. "/themes/custom/theme.lua")

-- Enabled Layouts
awful.layout.layouts = {
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
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}


menubar.utils.terminal = terminal -- Set the terminal for applications that require it

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
  awful.button({ }, 1, function(t) t:view_only() end),
  awful.button({ modkey }, 1, function(t)
    if client.focus then
        client.focus:move_to_tag(t)
    end
  end),
  awful.button({ }, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
    if client.focus then
        client.focus:toggle_tag(t)
    end
  end),
  awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
  awful.button({ }, 1, function (c)
    if c == client.focus then
        c.minimized = true
    else
        c:emit_signal(
            "request::activate",
            "tasklist",
            {raise = true}
        )
    end
  end),
  awful.button({ }, 3, function() awful.menu.client_list({ theme = { width = 250 } })end),
  awful.button({ }, 4, function () awful.client.focus.byidx(1) end),
  awful.button({ }, 5, function () awful.client.focus.byidx(-1) end)
)

local function set_wallpaper(s)
  -- Wallpaper
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)
  end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)


awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)

  -- Each screen has its own tag table.
  awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()
  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(gears.table.join(
   awful.button({ }, 1, function () awful.layout.inc( 1) end),
   awful.button({ }, 3, function () awful.layout.inc(-1) end),
   awful.button({ }, 4, function () awful.layout.inc( 1) end),
   awful.button({ }, 5, function () awful.layout.inc(-1) end)
  ))
  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.all,
    buttons = taglist_buttons
  }

  -- Create a tasklist widget
  -- s.mytasklist = awful.widget.tasklist {
  --     screen  = s,
  --     filter  = awful.widget.tasklist.filter.currenttags,
  --     buttons = tasklist_buttons
  -- }
  s.mytasklist = awful.widget.tasklist {
    screen   = s,
    filter   = awful.widget.tasklist.filter.currenttags,
    buttons  = tasklist_buttons,
    layout   = {
      spacing_widget = {
        {
          forced_width  = 5,
          forced_height = 24,
          thickness     = 1,
          color         = "#777777",
          widget        = wibox.widget.separator
        },
        valign = "center",
        halign = "center",
        widget = wibox.container.place,
      },
      spacing = 1,
      layout  = wibox.layout.fixed.horizontal
    },
      -- Notice that there is *NO* wibox.wibox prefix, it is a template,
      -- not a widget instance.
    -- widget_template = {
    --   {
    --     wibox.widget.base.make_widget(),
    --     forced_height = 5,
    --     id            = "background_role",
    --     widget        = wibox.container.background,
    --   },
    --   {
    --       -- awful.widget.clienticon,
    --     {
    --       id = "icon_role",
    --       widget = wibox.widget.imagebox
    --       -- id = "clienticon",
    --       -- widget = awful.widget.clienticon
    --     },
    --     margins = 5,
    --     widget  = wibox.container.margin,
    --   },
    --   nil,
    --   layout = wibox.layout.align.vertical,
    --   -- create_callback = function(self, c, _, _)
    --   --   self:get_children_by_id("clienticon")[1].client = c
    --   -- end
    -- }
    widget_template = {
      {
        {
          {
            {
              id     = "icon_role",
              widget = wibox.widget.imagebox,
            },
            margins = 2,
            widget  = wibox.container.margin,
          },
          {
            id     = "text_role",
            widget = wibox.widget.textbox,
          },
          layout = wibox.layout.fixed.horizontal,
        },
        left  = 0,
        right = 10,
        widget = wibox.container.margin
      },
      id     = "background_role",
      widget = wibox.container.background,
    }
  }
  -- Create the wibox
  s.mywibox = awful.wibar({ position = "top", screen = s })

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      wibox.widget.textclock(),
      -- mylauncher,
      s.mypromptbox,
    },
    s.mytasklist, -- Middle widget
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      -- mykeyboardlayout,
      sensor_var,
      s.mytaglist,
      -- battery_widget(),
      volume_widget({widget_type="icon"}),
      wibox.widget.systray(),
      s.mylayoutbox,
    },
  }
end)

-- {{{ Mouse bindings
-- root.buttons(gears.table.join(
--     awful.button({ }, 3, function () mymainmenu:toggle() end),
--     awful.button({ }, 4, awful.tag.viewnext),
--     awful.button({ }, 5, awful.tag.viewprev)
-- ))
-- }}}

local globalkeys = gears.table.join(
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
  awful.key({ modkey }, "x",
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
      awful.spawn.with_shell("pactl set-sink-mute @DEFAULT_SINK@ toggle")
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
      awful.spawn("dolphin")
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
)

local clientkeys = gears.table.join(
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
    end ,
    {description = "minimize", group = "client"}
  ),
  awful.key({ modkey }, "a",
    function (c)
      c.maximized = not c.maximized
      c:raise()
    end ,
    {description = "(un)maximize", group = "client"}
  ),
  awful.key({ modkey }, "t",
    function (c)
      c.ontop = not c.ontop
    end,
    {description = "toggle keep on top", group = "client"}
  )
    -- awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
    --           {description = "move to master", group = "client"}),
    -- awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
    --           {description = "move to screen", group = "client"}),
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  globalkeys = gears.table.join(globalkeys,
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

local clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)



-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
  -- All clients will match this rule.
  {
    rule = { },
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = clientkeys,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap+awful.placement.no_offscreen
   }
  },

  -- Floating clients.
  {
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
        "xtightvncviewer"
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
    properties = { floating = true }
  },

  -- Add titlebars to normal clients and dialogs
  {
    rule_any = {
      type = { "normal", "dialog" }
    },
    properties = { titlebars_enabled = false }
  },

  -- Set Firefox to always map on the tag named "2" on screen 1.
  -- { rule = { class = "Firefox" },
  --   properties = { screen = 1, tag = "2" } },
}

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it master.
  -- if not awesome.startup then awful.client.setslave(c) end

  if awesome.startup
    and not c.size_hints.user_position
    and not c.size_hints.program_position then
      -- Prevent clients from being unreachable after screen count changes.
      awful.placement.no_offscreen(c)
  end
  c.shape = function(cr, w, h)
    gears.shape.rounded_rect(cr, w, h, 8)
  end
-- c.border_width = 2
end)

client.connect_signal("property::maximized", function(c)
  c.border_width = c.maximized and 0 or beautiful.border_width
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
  -- buttons for the titlebar
  local buttons = gears.table.join(
      awful.button({ }, 1, function()
          c:emit_signal("request::activate", "titlebar", {raise = true})
          awful.mouse.client.move(c)
      end),
      awful.button({ }, 3, function()
          c:emit_signal("request::activate", "titlebar", {raise = true})
          awful.mouse.client.resize(c)
      end)
  )

  awful.titlebar(c) : setup {
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

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

awful.spawn.with_shell(script_dir .. "/autorun.sh")
