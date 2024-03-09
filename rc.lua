local naughty = require("naughty")

-- Error handling
naughty.connect_signal("request::display_error", function(message, startup)
  naughty.notification {
      urgency = "critical",
      title   = "Oops, an error happened"..(startup and " during startup!" or "!"),
      message = message
  }
end)

require('theme.init')

require('layout.init')

require('config.init')

require('module.init')
