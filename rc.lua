-- ~/.config/awesome/rc.lua
local naughty   = require("naughty")
local beautiful = require("beautiful")
local awful     = require('awful')
local gears     = require("gears")
local menubar   = require("menubar")

local globals   = require('main.globals')

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
local layout = require('main.layout')
awful.layout.layouts = layout.layouts

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

  layout:setup({
    screen    = screen,
    floating  = true,
    tag_count = 4,
  })
  screen.panel = panel { 
    screen    = screen,
  }
end)

-- Key bindings
require("awful.hotkeys_popup.keys") -- Enable hotkeys help widget for vim-likes
local global_bindings = require('binding.global')
root.buttons(global_bindings.buttons)
root.keys(global_bindings.keys)

-- Autofocus
require("awful.autofocus")

-- Client rules
local rules = require('main.rules')
awful.rules.rules = rules.rules

-- Signals
local signals = require('main.signals')
for _, signal in ipairs(signals.signals) do
  client.connect_signal(signal.id, signal.fun)
end

tag.connect_signal("property::layout", function(t)
  local clients = t:clients()
  for _,c in pairs(clients) do
    if c.floating or c.first_tag.layout.name == "floating" then
      awful.titlebar.show(c, "top")
      awful.titlebar.show(c, "bottom")
      c.border_width = beautiful.border_width
    else
      awful.titlebar.hide(c, "top")
      awful.titlebar.hide(c, "bottom")
      c.border_width = beautiful.border_width_alt
    end
  end
end)

-- Misc
awful.util.shell = globals.app.shell -- For autostart & other things
menubar.utils.terminal = globals.app.terminal -- Set the terminal for applications that require it

-- Autostart
local autostart = require('main.autostart')
autostart.on_startup(globals.autostart.on_startup)
autostart.on_reload(globals.autostart.on_reload)

