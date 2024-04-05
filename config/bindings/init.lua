local awful = require('awful')

local global_bindings = require('config.bindings.global')
local client_bindings = require('config.bindings.client')

require("awful.autofocus")

-- Set global bindings
-- awful.mouse.append_global_mousebindings(global_bindings.mouse)
root.buttons(global_bindings.mouse)
root.keys(global_bindings.keys)

-- Set client bindings
-- client.connect_signal("request::default_mousebindings", function()
--     awful.mouse.append_client_mousebindings(client_bindings.mouse)
-- end)
-- client.connect_signal("request::default_keybindings", function()
--   awful.keyboard.append_client_keybindings(client_bindings.keys)
-- end)

