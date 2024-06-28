local awful = require('awful')

local client_bindings = require('binding.client')

local _M = {}

_M.rules =  {
  { -- Global rules
    rule = {},
    properties = {
      focus = awful.client.focus.filter,
      raise = true,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap+awful.placement.no_offscreen,
      buttons = client_bindings.buttons,
      keys = client_bindings.keys,
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
  { -- Spawn terminal centered
    rule_any = {
      class = {
        "konsole",
        "Alacritty"
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
    }
  },

  { -- Always floating
    rule_any = {
      name = {
        "Event Tester",  -- xev
        "test",
      },
    },
    properties = {
      floating = true,
      placement = awful.placement.centered,
    }
  },

  { -- No titlebar
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
      titlebars_enabled = false,
      floating = true
    }
  },

}

return _M
