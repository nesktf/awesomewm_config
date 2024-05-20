local awful = require('awful')

local app_rules = {
  { -- Hydrus media viewer fullscreen override
    rule_any = {
      name = {
        "hydrus client media viewer"
      }
    },
    properties = {
      fullscreen = true,
      placement = awful.placement.centered,
    }
  },
  { -- Always floating
    rule_any = {
      name = {
        "Event Tester",  -- xev.
      },
    },
    properties = {
      floating = true
    }
  },
  { -- No titlebar (GTK)
    rule_any = {
      name = {
        "Lutris"
      }
    },
    properties = {
      titlebars_enabled = false
    }
  },
  { -- Copyq
    rule = {
      class = "copyq"
    },
    properties = {
      placement = awful.placement.top_right,
      titlebars_enabled = false
    }
  },
}

return app_rules
