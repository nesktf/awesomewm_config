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
      titlebars_enabled = false,
      placement = awful.placement.centered,
    }
  }
  -- Apps that should alway spawn floating
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

end

return app_rules
