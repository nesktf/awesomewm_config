local awful = require('awful')
local ruled = require('ruled')

-- Rules to apply to new clients (through the "manage" signal).
ruled.client.connect_signal("request::rules", function()
  -- Global rules
  ruled.client.append_rule{
    id = "global",
    rule = {},
    properties = {
      focus = awful.client.focus.filter,
      raise = true,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap+awful.placement.no_offscreen,
      floating = true -- Floating by default
    }
  }
  -- Setup tilebars for each window
  ruled.client.append_rule {
    id = "titlebar_init",
    rule_any = {
      type = { "normal", "dialog" },
    },
    properties = {
      titlebars_enabled = true
    }
  }
  -- Dialog window prperties
  ruled.client.append_rule {
    id = "dialog_props",
    rule = {
      type = "dialog"
    },
    properties = {
      placement = awful.placement.centered
    }
  }

  require('config.client.rules.kde_rules')()
  require('config.client.rules.app_rules')()
end)

ruled.notification.connect_signal("request::rules", function()
  require('config.client.rules.notification_rules')()
end)
