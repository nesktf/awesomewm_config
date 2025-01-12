-- ~/.config/awesome/rc.lua
pcall(require, "luarocks.loader")
local naughty   = require("naughty")
local beautiful = require("beautiful")
local awful     = require('awful')
local gears     = require('gears')
local menubar   = require("menubar")
local awesome   = awesome
local client    = client
local tag       = tag

local themes   = require('themes')
local widget   = require('widget')
local lclient  = require('client')
local signals  = require('signals')
local config   = require('config')
local binds    = require('binds')

local util = require("util")

-- local profiles = require("profiles")

local function main()
  require("awful.autofocus")
  require("awful.hotkeys_popup.keys") -- Enable hotkeys help widget for vim-likes

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

  awesome.set_preferred_icon_size(128) -- ?
  beautiful.init(themes.breeze_like.settings_with {
    font       = "Cousine Nerd Font 9",
    icon_theme = "Tela black dark",
    wallpaper  = "marisa1",
  })

  local tags = {"main", "dev", "web", "gaems", "media"}
  local layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.fair,
    awful.layout.suit.spiral,
    awful.layout.suit.max,
    awful.layout.suit.magnifier,
  }

  awful.layout.layouts = layouts
  awful.rules.rules = lclient.rules.get()
  awful.util.shell = config.globals.env.shell -- For autostart
  menubar.utils.terminal = config.globals.env.term

  awful.screen.connect_for_each_screen(function(s)
    util.apply_pape(s)

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
  root.buttons(gears.table.join(
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
  ))

  util.connect_signal(client, signals.client())
  util.connect_signal(tag, signals.tag())

  config.autostart.trigger()
end

main()
