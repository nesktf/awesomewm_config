local awful = require('awful')
local ruled = require('ruled')

local function kde_rules()
  -- Center every kde dialog like app
  ruled.client.append_rule {
    id = "kde_windows",
    rule_any = {
      class = {
        "keditfiletype",
        "xdg-desktop-portal-kde",
        "spectacle",
      }
    },
    properties = {
      placement = awful.placement.centered
    }
  }
  -- Spawn konsole centered
  ruled.client.append_rule {
    id = "konsole_rules",
    rule = {
      class = "konsole"
    },
    properties = {
      placement = awful.placement.centered
    }
  }
  -- -- Same for dolphin dialogs
  -- ruled.client.append_rule {
  --   id = "dolphin_dialogs",
  --   rule = {
  --     type = "dialog",
  --     class = "dolphin"
  --   },
  --   properties = {
  --     placement = awful.placement.centered
  --   }
  -- }
end

return kde_rules
