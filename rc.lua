-- ~/.config/awesome/rc.lua
local naughty   = require("naughty")
local beautiful = require("beautiful")
local awful     = require('awful')
local gears     = require('gears')
local menubar   = require("menubar")
local gawesome  = awesome
local gclient   = client
local gtag      = tag

local themes  = require('themes')
local widget  = require('widget')
local client  = require('client')
local signals = require('signals')
local config  = require('config')
local binds   = require('binds')

local function init_error_handler()
  if (gawesome.startup_errors) then
    naughty.notify({ 
      preset  = naughty.config.presets.critical,
      title   = "Oops, there were errors during startup!",
      text    = gawesome.startup_errors
    })
  end

  local in_error = false
  gawesome.connect_signal("debug::error", function(err)
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

local function main()
  init_error_handler()

  require("awful.autofocus")
  require("awful.hotkeys_popup.keys") -- Enable hotkeys help widget for vim-likes

  awesome.set_preferred_icon_size(128) -- ?
  beautiful.init(themes.breeze_like.settings_with {
    font       = "Cousine Nerd Font 8",
    icon_theme = "Tela black dark",
    wallpaper  = "marisa0",
  })

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
  awful.rules.rules = client.rules.get()
  awful.util.shell = config.globals.env.shell -- For autostart
  menubar.utils.terminal = config.globals.env.term

  awful.screen.connect_for_each_screen(function(s)
    themes.util.apply_pape(s)

    for i, tag_name in ipairs(tags) do
      awful.tag.add(tag_name, {
        screen   = s,
        layout   = layouts[1], -- Floating
        selected = (i == 1), -- Select first tag
      })
    end

    s.panel = widget.panel {
      screen = s,
    }
  end)

  root.keys(gears.table.join(binds.get(), binds.gen_for_tags(tags)))

  signals.connect(gclient, signals.client())
  signals.connect(gtag, signals.tag()) 

  widget.panel.update_workers()
  config.autostart.trigger()
end

main()
