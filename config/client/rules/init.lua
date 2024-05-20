local awful = require('awful')

local client_bindings = require('config.bindings.client')

awful.rules.rules = {
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
  require('config.client.rules.kde_rules'),
  require('config.client.rules.app_rules'),

  -- { -- Global notification rules
  --   rule = {},
  --   properties = {
  --     screen = awful.screen.preferred,
  --     implicit_timeout = 5
  --   }
  -- }
}

-- ruled.notification.connect_signal("request::rules", function()
--   require('config.client.rules.notification_rules')()
-- end)
