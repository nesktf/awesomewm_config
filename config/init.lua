local awful = require('awful')
local menubar = require("menubar")
local apps = require('config.apps')

require('config.bindings')
require('config.client')

awesome.set_preferred_icon_size(128)

awful.util.shell = "bash"
menubar.utils.terminal = apps.list.terminal -- Set the terminal for applications that require it
