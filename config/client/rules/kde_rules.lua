local awful = require('awful')

local kde_rules = {
  { -- Center every kde dialog like window
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
  },
  { -- Spawn konsole centered
    rule = {
      class = "konsole"
    },
    properties = {
      placement = awful.placement.centered
    }
  },
  -- { -- Same for dolphin dialogs
  --   rule = {
  --     type = "dialog",
  --     class = "dolphin"
  --   },
  --   properties = {
  --     placement = awful.placement.centered
  --   }
  -- }
}

return kde_rules
