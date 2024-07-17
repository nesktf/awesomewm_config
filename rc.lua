-- ~/.config/awesome/rc.lua
local naughty   = require("naughty")
local beautiful = require("beautiful")
local awful     = require('awful')
local gears     = require("gears")
local menubar   = require("menubar")

local globals   = require('config.globals')

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
local theme = require('themes.breeze-like')
beautiful.init(theme.theme)
awesome.set_preferred_icon_size(128) -- ?

-- Bind panel, wallpaper & layout
local tags = require('tags')
tags:init({ "Main", "Browser", "Gaems", "Media" })

local panel = require('widget.panel')
awful.screen.connect_for_each_screen(function(screen)
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(screen)
    end
    gears.wallpaper.maximized(wallpaper, screen, false)
  end

  tags:setup_for_screen({
    screen   = screen,
    floating = false,
  })
  screen.panel = panel { 
    screen    = screen,
    floating = true,
    rounded = true,
  }
end)

-- Key bindings
require("awful.hotkeys_popup.keys") -- Enable hotkeys help widget for vim-likes
local global_bindings = require('binding.global')
-- root.buttons(global_bindings.buttons)
local keys = gears.table.join(global_bindings.keys, tags:create_bindings())
root.keys(keys)

-- Autofocus
require("awful.autofocus")

-- Client rules
local rules = require('rules')
awful.rules.rules = rules.rules

-- Signals
local signals = require('signals')
for _,signal in ipairs(signals.client) do
  client.connect_signal(signal.id, signal.callback)
end
for _, signal in ipairs(signals.tag) do
  tag.connect_signal(signal.id, signal.callback)
end

-- Misc
awful.util.shell = globals.env.shell -- For autostart & other things
menubar.utils.terminal = globals.env.term -- Set the terminal for applications that require it

-- Autostart
local autostart = require('config.autostart')
autostart.on_startup()
autostart.on_reload()
