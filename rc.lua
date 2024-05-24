-- ~/.config/awesome/rc.lua
-- Libs
local naughty   = require("naughty")
local beautiful = require("beautiful")
local awful     = require('awful')
local gears     = require("gears")
local menubar   = require("menubar")

local const     = require("config.const")

do -- Error handling
  if awesome.startup_errors then
    naughty.notify({ 
      preset  = naughty.config.presets.critical,
      title   = "Oops, there were errors during startup!",
      text    = awesome.startup_errors
    })
  end

  local in_error = false
  awesome.connect_signal("debug::error", function (err)
    -- Make sure we don't go into an endless error loop
    if in_error then return end
    in_error = true

    naughty.notify({ 
      preset  = naughty.config.presets.critical,
      title   = "Oops, an error happened!",
      text    = tostring(err)
    })
    in_error = false
  end)
end

-- Theme things
beautiful.init(const.path.awesome_dir .. "/theme/theme.lua")
awesome.set_preferred_icon_size(128) -- ?

-- Wallpaper
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

-- Layouts
awful.layout.layouts = {
    awful.layout.suit.tile,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    awful.layout.suit.floating,
    awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
}

-- Panel
local create_panel = require('layout.panel')

-- Bind panel & wallpaper
awful.screen.connect_for_each_screen(function(s)
  set_wallpaper(s)
  s.panel = create_panel(s)
end)

-- Autofocus
require("awful.autofocus")

-- Global bindings
local global_bindings = require('config.bindings.global')
root.buttons(global_bindings.mouse)
root.keys(global_bindings.keys)

-- Titlebar
local create_titlebar = require('config.client.titlebar')
client.connect_signal("request::titlebars", create_titlebar)

-- Client rules
local client_rules = require('config.client.rules')
awful.rules.rules = client_rules

-- Signals
local signals = require('config.client.signals')
for _, signal in ipairs(signals) do
  client.connect_signal(signal.id, signal.fun)
end

-- Misc
local apps = require('config.apps')
awful.util.shell        = apps.list.shell -- For autostart & other things
menubar.utils.terminal  = apps.list.terminal -- Set the terminal for applications that require it

-- Autostart
local autostart = require('module.autostart')
autostart(apps)
