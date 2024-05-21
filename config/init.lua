-- Configs

local awful = require('awful')
local menubar = require("menubar")
local apps = require('config.apps')

-- Autofocus
require("awful.autofocus")

-- Global bindings
local global_bindings = require('config.bindings.global')
root.buttons(global_bindings.mouse)
root.keys(global_bindings.keys)

-- Titlebar
local titlebar = require('config.client.titlebar')
client.connect_signal("request::titlebars", titlebar)

-- Client rules
local client_rules = require('config.client.rules')
awful.rules.rules = client_rules

-- Signals
local signals = require('config.client.signals')
for _, signal in ipairs(signals) do
  client.connect_signal(signal.id, signal.fun)
end

awesome.set_preferred_icon_size(128) -- ?
awful.util.shell = "bash" -- For autostart & other things
menubar.utils.terminal = apps.list.terminal -- Set the terminal for applications that require it
