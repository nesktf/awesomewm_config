local awful     = require('awful')
local beautiful = require('beautiful')

local titlebar = require('widget.titlebar')

local function toggle_panel_floating(t)
  if (not t.screen.panel) then return end
  if (t.layout.name == "floating") then
    t.screen.panel:set_floating(false)
    t.screen.panel:set_rounded(false)
  else
    t.screen.panel:set_floating(true)
    t.screen.panel:set_rounded(true)
  end
end

local _M = {}

_M.client = {
  {
    id = "manage",
    callback = function(c)
      -- Set the windows at the slave,
      -- i.e. put it at the end of others instead of setting it master.
      -- if not awesome.startup then awful.client.setslave(c) end
      if awesome.startup
        and not c.size_hints.user_position
        and not c.size_hints.program_position then
          -- Prevent clients from being unreachable after screen count changes.
          awful.placement.no_offscreen(c)
      end

      titlebar.update_titlebars(c)
      if (c.fullscreen and c.y ~= c.screen.y) then -- >:c
        c.y = c.screen.geometry.y
        c.height = c.screen.geometry.height
      end
    end
  },
  {
    id = "focus",
    callback = function(c)
      c.border_color = beautiful.border_focus
    end
  },
  {
    id = "unfocus",
    callback = function(c)
      c.border_color = beautiful.border_normal
    end
  },
  {
    id = "request::titlebars",
    callback = function(c)
      c.titlebar = titlebar.create(c)
    end
  },
  {
    id = "property::floating",
    callback = function(c)
      titlebar.update_titlebars(c)
    end
  },
}

_M.tag = {
  {
    id = "property::layout", 
    callback = function(t)
      local clients = t:clients()
      for _,c in pairs(clients) do
        titlebar.update_titlebars(c)
      end
    end
  },
  -- {
  --   id = "property::selected",
  --   callback = function(t)
  --     if (t.selected) then
  --       toggle_panel_floating(t)
  --     end
  --   end,
  -- }
}

return _M
