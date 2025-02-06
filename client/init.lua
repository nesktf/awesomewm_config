local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local theme = require('theme')

local util  = require('client.util')
local rules = require('client.rules')

local function setup_titlebars(c)
  assert(c ~= nil)

  local titlebar = {
    top = awful.titlebar(c, {
      position = "top",
      size     = theme.titlebar_top_size,
    }),
    bottom = awful.titlebar(c, {
      position = "bottom",
      size     = theme.titlebar_bot_size,
    }),
  }

  titlebar.top:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left
      widget = wibox.container.margin,
      top = 3, bottom = 3, left = 3, right = 5,
      {
        layout  = wibox.layout.fixed.horizontal,
        spacing = 4,
        awful.titlebar.widget.stickybutton(c),
        awful.titlebar.widget.ontopbutton(c),
        awful.titlebar.widget.floatingbutton(c),
      }
    },
    { -- Middle
      layout  = wibox.layout.flex.horizontal,
      buttons = gears.table.join(
        awful.button({ }, 1, function()
          c:emit_signal("request::activate", "titlebar", {raise = true})
          awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
          c:emit_signal("request::activate", "titlebar", {raise = true})
          awful.mouse.c.resize(c)
        end)
      ),
      awful.titlebar.widget.titlewidget(c),
    },
    { -- Right
      widget = wibox.container.margin,
      top = 3, bottom = 3, right = 3,
      {
        layout = wibox.layout.fixed.horizontal,
        spacing = 4,
        awful.titlebar.widget.minimizebutton(c),
        (function()
          local widget = awful.titlebar.widget.button(c, "maximized", 
            function(cl) return cl.maximized end,
            function(cl, _) util.toggle_maximize(cl) end
          )
          c:connect_signal("property::maximized", widget.update)
          return widget
        end)(),
        awful.titlebar.widget.closebutton(c),
      } 
    },
  }

  titlebar.bottom:setup {
    widget = wibox.container.background,
  }
end

local _M = {}

_M.rules = rules

_M.signals = {
  {
    id = "manage",
    callback = function(c)
      -- Set the windows at the slave, i.e. put it at the end of others
      -- instead of setting it master.
      -- if (not awesome.startup) then
      --   awful.client.setslave(c)
      -- end

      -- Prevent clients from being unreachable after screen count changes.
      if (awesome.startup
          and not c.size_hints.user_position and not c.size_hints.program_position) then
        awful.placement.no_offscreen(c)
      end

      if (c.maximized) then
        c.maximized = false
      end
      util.update_titlebar(c)
    end,
  },
  {
    id = "focus",
    callback = function(c)
      c.border_color = theme.border_focus
    end,
  },
  {
    id = "unfocus",
    callback = function(c)
      c.border_color = theme.border_normal
    end,
  },
  {
    id = "request::titlebars",
    callback = setup_titlebars,
  },
  {
    id = "property::floating",
    callback = function(c)
      if (not c.maximized and not c.fullscreen) then
        util.update_titlebar(c)
      end
    end,
  },
  {
    id = "property::maximized",
    callback = function(c)
      util.update_titlebar(c)
      c:raise()
    end,
  },
  {
    id = "property::fullscreen",
    callback = function(c)
      util.update_titlebar(c)
      c:raise()
    end,
  },
  {
    id = "tagged",
    callback = function(c, t)
      if (c.maximized) then
        t.maximized_count = t.maximized_count+1
      end
      t.screen.panel:set_floating(t.maximized_count == 0)
      util.update_titlebar(c)
    end,
  },
  {
    id = "untagged",
    callback = function(c, t)
      if (c.maximized) then
        t.maximized_count = t.maximized_count-1
      end
      t.screen.panel:set_floating(t.maximized_count == 0)
    end,
  },
}

return _M
