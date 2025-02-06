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

local theme    = require('theme')
local widget   = require('widget')
local lclient  = require('client')
local ltag     = require('tag')
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
  beautiful.init(theme.get())

  awful.layout.layouts = ltag.layouts
  awful.rules.rules = lclient.rules
  awful.util.shell = config.globals.env.shell -- For autostart
  menubar.utils.terminal = config.globals.env.term

  awful.screen.connect_for_each_screen(function(s)
    util.apply_pape(s)

    for i, curr_tag in ipairs(ltag.tags) do
      local t = awful.tag.add(curr_tag.name, {
        screen   = s,
        layout   = ltag.layouts[curr_tag.layout],
        selected = (i == 1), -- Select first tag
      })
      t.maximized_count = 0
    end

    s.panel = widget.panel {
      screen = s,
      floating = theme.panel_floating,
      rounded = theme.panel_rounded,
    }
  end)
  awful.screen.focused().panel:make_tray_current()

  root.keys(gears.table.join(binds.keys, ltag.keys))
  root.buttons(binds.buttons)

  for _, signal in ipairs(lclient.signals) do
    client.connect_signal(signal.id, signal.callback)
  end

  for _, signal in ipairs(ltag.signals) do
    tag.connect_signal(signal.id, signal.callback)
  end

  config.autostart.trigger()
end

main()
