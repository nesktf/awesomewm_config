-- ~/.config/awesome/rc.lua
local naughty   = require("naughty")
local beautiful = require("beautiful")
local awful     = require('awful')
local gears     = require('gears')
local menubar   = require("menubar")
local gclient   = client

local themes  = require('themes')
local widget  = require('widget')
local client  = require('client')
local signals = require('signals')
local config  = require('config')
local binds   = require('binds')

do -- Error handling
  if (awesome.startup_errors) then
    naughty.notify({ 
      preset  = naughty.config.presets.critical,
      title   = "Oops, there were errors during startup!",
      text    = awesome.startup_errors
    })
  end

  local in_error = false
  awesome.connect_signal("debug::error", function(err)
    -- Make sure we don't go into an endless error loop
    if (in_error) then
      return
    end
    in_error = true

    naughty.notify({ 
      preset  = naughty.config.presets.critical,
      title   = "Oops, an error happened!",
      text    = tostring(err)
    })
    in_error = false
  end)
end

require("awful.autofocus") -- Autofocus
require("awful.hotkeys_popup.keys") -- Enable hotkeys help widget for vim-likes

beautiful.init(themes.breeze_like.settings_with{
  font       = "Cousine Nerd Font 8",
  icon_theme = "Tela black dark",
  wallpaper  = "marisa0",
})
awesome.set_preferred_icon_size(128) -- ?

local tags = {"1", "2", "3", "4"}
local layouts = {
  awful.layout.suit.floating,
  awful.layout.suit.tile,
  awful.layout.suit.tile.bottom,
  awful.layout.suit.fair,
  awful.layout.suit.spiral,
  awful.layout.suit.corner.nw,
}
awful.layout.layouts = layouts

awful.screen.connect_for_each_screen(function(s)
  themes.util.apply_pape(s)

  local selected = 1
  local floating = true
  for i, tag_name in ipairs(tags) do
    awful.tag.add(tag_name, {
      screen   = s,
      layout   = floating and layouts[1] or layouts[2],
      selected = (i == selected),
    })
  end

  s.panel = widget.panel {
    screen = s,
  }
end)

awful.rules.rules = client.rules.get()

awful.util.shell = config.globals.env.shell -- For autostart
menubar.utils.terminal = config.globals.env.term

signals.connect(gclient, signals.client())
signals.connect(tag, signals.tag())

root.keys(gears.table.join(binds.get(), binds.gen_for_tags(tags)))

widget.panel.update_workers()
config.autostart.trigger()
