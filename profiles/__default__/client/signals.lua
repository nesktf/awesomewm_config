local awful     = require('awful')
local beautiful = require('beautiful')

local titlebar = require("client.titlebar")

local function __signal(id, callback)
  return {id=id, callback=callback}
end

local __client_signals = {
  __signal("manage", function(c)
    -- Set the windows at the slave, i.e. put it at the end of others instead of setting it master.
    -- if (not awesome.startup) then
    --   awful.client.setslave(c)
    -- end

    -- Prevent clients from being unreachable after screen count changes.
    if (awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position) then
      awful.placement.no_offscreen(c)
    end

    titlebar.update(c)
    if (c.fullscreen and c.y ~= c.screen.y) then -- >:c
      c.y = c.screen.geometry.y
      c.height = c.screen.geometry.height
    end
  end),

  __signal("focus", function(c)
    c.border_color = beautiful.border_focus
  end),

  __signal("unfocus", function(c)
    c.border_color = beautiful.border_normal
  end),

  __signal("request::titlebars", function(c)
    c.titlebars = titlebar(c)
  end),

  __signal("property::floating", function(c)
    titlebar.update(c)
  end),
}

local __tag_signals = {
  __signal("property::layout", function(t)
    local clients = t:clients()
    for _,c in pairs(clients) do
      titlebar.update(c)
    end
  end),

  -- __signal("property::selected", function(t)
  --   if (t.selected) then
  --     toggle_panel_floating(t)
  --   end
  -- end)
}

local _M = {}

function _M.client()
  return __client_signals
end

function _M.tag()
  return __tag_signals
end

return _M
