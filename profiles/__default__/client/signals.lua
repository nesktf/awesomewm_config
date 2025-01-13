local awful     = require('awful')
local beautiful = require('beautiful')

local titlebar = require("client.titlebar")

local function signal(id, callback)
  return {id=id, callback=callback}
end

local _client_signals = {
  signal("manage", function(c)
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

  signal("focus", function(c)
    c.border_color = beautiful.border_focus
  end),

  signal("unfocus", function(c)
    c.border_color = beautiful.border_normal
  end),

  signal("request::titlebars", function(c)
    c.titlebars = titlebar(c)
  end),

  signal("property::floating", function(c)
    titlebar.update(c)
  end),

  signal("property::tagged", function(c)
    require("naughty").notify{text = c.name}
  end)
}

local _tag_signals = {
  signal("property::layout", function(t)
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

return {
  client = function()
    return _client_signals
  end,
  tag = function()
    return _tag_signals
  end
}
