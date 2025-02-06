local awful = require('awful')
local binds = require('client.binds')

return {
  { -- Global rules
    rule = {},
    properties = {
      focus = awful.client.focus.filter,
      raise = true,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap+awful.placement.no_offscreen,
      buttons = binds.buttons,
      keys = binds.keys,
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
    rule = {
      name = "hydrus client media viewer",
    },
    properties = {
      fullscreen = false,
      placement = awful.placement.centered,
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
        ""
      };
      name = {
        "Picture-in-picture",
      }
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
