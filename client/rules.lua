local awful = require('awful')

local cbinds = require('client.binds')

local __client_rules =  {
  { -- Global rules
    rule = {},
    properties = {
      focus = awful.client.focus.filter,
      raise = true,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap+awful.placement.no_offscreen,
      buttons = cbinds.buttons,
      keys = cbinds.keys,
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
  { -- Center every dialog like window
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
  { -- Spawn terminal centered
    rule_any = {
      class = {
        "konsole",
        "Alacritty",
        "mpv",
      }
    },
    properties = {
      placement = awful.placement.centered
    }
  },
  { -- Hydrus media viewer fullscreen override
    rule_any = {
      name = {
        "hydrus client media viewer"
      }
    },
    properties = {
      fullscreen = true,
      placement = awful.placement.centered,
      floating = true,
    }
  },
  { -- Always floating
    rule_any = {
      name = {
        "Event Tester",  -- xev
        "test",
        "Network Connections",
      },
      class = {
        "nm-connection-editor",
      }
    },
    properties = {
      floating = true,
      placement = awful.placement.centered,
    }
  },
  { -- No titlebar
    rule_any = {
      instance = {
        "lutris",
        "steam",
        "steamwebhelper",
      };
    },
    properties = { titlebars_enabled = false }
  },
  { -- Copyq
    rule = {
      class = "copyq"
    },
    properties = {
      placement = awful.placement.top_right,
      titlebars_enabled = false,
      floating = true
    }
  },
}

local _M = {}

function _M.get()
  return __client_rules
end

return _M
