local awful = require('awful')
local ruled = require('ruled')

local function notification_rules()
  -- Global notification rules
  ruled.notification.append_rule {
    rule = {},
    properties = {
      screen = awful.screen.preferred,
      implicit_timeout = 5
    }
  }
end

return notification_rules
