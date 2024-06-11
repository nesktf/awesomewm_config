local awful     = require('awful')
local gears     = require('gears')
local beautiful = require('beautiful')

local titlebar = require('ui.titlebar')

local _M = {}

_M.signals = {
  {
    id = "manage",
    fun = function(c)
      -- Set the windows at the slave,
      -- i.e. put it at the end of others instead of setting it master.
      -- if not awesome.startup then awful.client.setslave(c) end
      if awesome.startup
        and not c.size_hints.user_position
        and not c.size_hints.program_position then
          -- Prevent clients from being unreachable after screen count changes.
          awful.placement.no_offscreen(c)
      end
      -- c.shape = function(cr, w, h)
      --   gears.shape.rounded_rect(cr, w, h, 4)
      -- end
    end
  },
  {
    id = "property::maximized",
    fun = function(c)
      c.border_width = c.maximized and 0 or beautiful.border_width
    end
  },
  {
    id = "focus",
    fun = function(c)
      c.border_color = beautiful.border_focus
    end
  },
  {
    id = "unfocus",
    fun = function(c)
      c.border_color = beautiful.border_normal
    end
  },
  {
    id = "request::titlebars",
    fun = function(c)
      titlebar.attach_floating(c)
    end
  }
}

return _M
