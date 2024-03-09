local menubar = require("menubar")
local naughty = require("naughty")

-- Error handling
naughty.connect_signal("request::display_error", function(message, startup)
  naughty.notification {
      urgency = "critical",
      title   = "Oops, an error happened"..(startup and " during startup!" or "!"),
      message = message
  }
end)

local terminal = "alacritty"
menubar.utils.terminal = terminal -- Set the terminal for applications that require it

require('theme')

require('layout')

require('config')

require('modules')

