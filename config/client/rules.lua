local awful = require('awful')
local ruled = require('ruled')


-- local clientbuttons = awful.util.table.join(
--     awful.button({ }, 1, function (c)
--       c:emit_signal("request::activate", "mouse_click", {raise = true})
--     end),
--     awful.button({ modkey }, 1, function (c)
--       c:emit_signal("request::activate", "mouse_click", {raise = true})
--       awful.mouse.client.move(c)
--     end),
--     awful.button({ modkey }, 3, function (c)
--       c:emit_signal("request::activate", "mouse_click", {raise = true})
--       if c.floating then awful.mouse.client.resize(c) end
--       -- awful.mouse.client.resize(c)
--     end)
-- )
--
-- Rules to apply to new clients (through the "manage" signal).
ruled.client.connect_signal("request::rules", function()
  ruled.client.append_rule {
    id = "global",
    rule = {},
    properties = {
      -- border_width = beautiful.border_width,
      -- border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      -- keys = clientkeys,
      -- buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap+awful.placement.no_offscreen
    }
  }
  ruled.client.append_rule {
    id = "floating",
    rule_any = {
      instance = {
        "DTA",  -- Firefox addon DownThemAll.
        "copyq",  -- Includes session name in class.
        "pinentry",
      },
      class = {
        "Arandr",
        "Blueman-manager",
        "Gpick",
        "Kruler",
        "MessageWin",  -- kalarm.
        "Sxiv",
        "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
        "Wpa_gui",
        "veromix",
        "xtightvncviewer",
        "xdg-desktop-portal-kde",
        "spectacle"
      },

      -- Note that the name property shown in xprop might be set slightly after creation of the client
      -- and the name shown there might not match defined rules here.
      name = {
        "Event Tester",  -- xev.
      },
      role = {
        "AlarmWindow",  -- Thunderbird's calendar.
        "ConfigManager",  -- Thunderbird's about:config.
        "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
      }
    },
    properties = {
      floating = true,
      placement = awful.placement.centered
    }
  }
  ruled.client.append_rule {
    id = "titlebars",
    rule_any = {
      type = { "normal", "dialog" },
      properties = { titlebars_enabled = true }
    }
  }
  ruled.client.append_rule {
   rule = {
      name = {
        "hydrus client media viewer"
      }
    },
    properties = {
      fullscreen = false,
      maximized = true,
      placement = awful.placement.centered
    }
  }
end)


