local awful     = require('awful')
local beautiful = require('beautiful')

local titlebar = require('widget.titlebar')

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

      if (c.floating or c.first_tag.layout.name == "floating") then
        awful.titlebar.show(c, "top")
        awful.titlebar.show(c, "bottom")
        c.border_width = beautiful.border_width
      else
        awful.titlebar.hide(c, "top")
        awful.titlebar.hide(c, "bottom")
        c.border_width = beautiful.border_width_alt
      end
    end
  },
  {
    id = "property::maximized",
    fun = function(c)
      if (c.maximized) then
        awful.titlebar.hide(c, "top")
        awful.titlebar.hide(c, "bottom")
      else
        awful.titlebar.show(c, "top")
        awful.titlebar.show(c, "bottom")
      end
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
      c.titlebar = titlebar { 
        client = c
      }
    end
  },
  {
    id = "property::floating",
    fun = function(c)
      if (c.floating) then
        awful.titlebar.show(c, "top")
        awful.titlebar.show(c, "bottom")
        c.border_width = beautiful.border_width
      else
        awful.titlebar.hide(c, "top")
        awful.titlebar.hide(c, "bottom")
        c.border_width = beautiful.border_width_alt
      end
    end
  },
}

return _M
