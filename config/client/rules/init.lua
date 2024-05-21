local awful = require('awful')
local gears = require('gears')

local client_bindings = require('config.bindings.client')

local app_rules = require('config.client.rules.app_rules')
local general_rules =  {
  { -- Global rules
    rule = {},
    properties = {
      focus = awful.client.focus.filter,
      raise = true,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap+awful.placement.no_offscreen,
      keys = client_bindings.keys,
      buttons = client_bindings.buttons,
      -- floating = true, -- Floating by default
    },
  },
  { -- Titlebar rule
    rule_any = {
      type = { "normal", "dialog" },
    },
    properties = { titlebars_enabled = true }
  },
  { -- Dialog window props
    rule = {
      type = "dialog"
    },
    properties = {
      placement = awful.placement.centered;
    }
  },
  -- { -- Global notification rules
  --   rule = {},
  --   properties = {
  --     screen = awful.screen.preferred,
  --     implicit_timeout = 5
  --   }
  -- }
}

return gears.table.join(general_rules, app_rules)

-- ruled.notification.connect_signal("request::rules", function()
--   require('config.client.rules.notification_rules')()
-- end)
