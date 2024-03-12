local awful = require('awful')
local ruled = require('ruled')

local function app_rules()
  -- Hydrus media viewer fullscreen override
  ruled.client.append_rule {
    id = "hydrus_viewer",
    rule_any = {
      name = {
        "hydrus client media viewer"
      }
    },
    properties = {
      fullscreen = true,
      placement = awful.placement.centered,
    }
  }
  -- Apps that should always spawn floating
  ruled.client.append_rule {
    id = "always_floating",
    rule_any = {
      name = {
        "Event Tester",  -- xev.
      },
    },
    properties = {
      floating = true
    }
  }
  -- Apps with no titlebar (GTK)
  ruled.client.append_rule {
    id = "no_titlebar",
    rule_any = {
      name = {
        "Lutris"
      }
    },
    properties = {
      titlebars_enabled = false
    }
  }
  -- Copyq
  ruled.client.append_rule {
    id = "copyq_thing",
    rule = {
      class = "copyq"
    },
    properties = {
      placement = awful.placement.top_right,
      titlebars_enabled = false
    }
  }
end

return app_rules
