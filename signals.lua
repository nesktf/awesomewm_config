local awful     = require('awful')
local beautiful = require('beautiful')

local titlebar = require("client").titlebar
local theme    = require('theme')

local function signal(id, callback)
  return {id=id, callback=callback}
end

local function is_floating(c)
  return
    (c.floating and not c.maximized) or
    (c.first_tag ~= nil and c.first_tag.layout.name == "floating")
end

local _client_signals = {
  signal("manage", function(c)
    -- Set the windows at the slave, i.e. put it at the end of others instead of setting it master.
    -- if (not awesome.startup) then
    --   awful.client.setslave(c)
    -- end

    -- Prevent clients from being unreachable after screen count changes.
    if (awesome.startup
        and not c.size_hints.user_position and not c.size_hints.program_position) then
      awful.placement.no_offscreen(c)
    end

    local floating = is_floating(c)
    titlebar.toggle(c, floating, floating)
    c.border_width = floating and theme.border_width or theme.border_width_tiling
    if (c.maximized) then
      c.border_width = 0
    end
  end),

  signal("focus", function(c)
    c.border_color = beautiful.border_focus
  end),

  signal("unfocus", function(c)
    c.border_color = beautiful.border_normal
  end),

  signal("request::titlebars", function(c)
    titlebar.setup(c)
  end),

  signal("property::floating", function(c)
    if (not c.maximized and not c.fullscreen) then
      titlebar.toggle(c, c.floating, c.floating)
      c.border_width = c.floating and theme.border_width or theme.border_width_tiling
    end
  end),

  signal("property::maximized", function(c)
    local toggle_titlebar = not c.maximized
    local floating = is_floating(c)
    local panel = c.screen.panel
    local t = c.first_tag

    titlebar.toggle(c, toggle_titlebar, floating)
    c.border_width =
      toggle_titlebar and (floating and theme.border_width or theme.border_width_tiling) or 0

    if (not t) then
      return
    end
    t.maximized_count = t.maximized_count + (toggle_titlebar and -1 or 1)
    panel:set_floating(t.maximized_count == 0)
  end),

  signal("property::fullscreen", function(c)
    if (not c.fullscreen) then
      local floating = is_floating(c)
      titlebar.toggle(c, not c.fullscreen, floating)
      c.border_width = floating and theme.border_width or theme.border_width_tiling
    end
  end),

  signal("tagged", function(c, t)
    if (c.maximized) then
      t.maximized_count = t.maximized_count+1
    end
    t.screen.panel:set_floating(t.maximized_count == 0)
  end),

  signal("untagged", function(c, t)
    if (c.maximized) then
      t.maximized_count = t.maximized_count-1
    end
    t.screen.panel:set_floating(t.maximized_count == 0)
  end)
}

local _tag_signals = {
  signal("property::layout", function(t)
    local clients = t:clients()
    for _,c in pairs(clients) do
      local floating = is_floating(c)
      titlebar.toggle(c, floating, floating)
      c.border_width = floating and theme.border_width or theme.border_width_tiling
    end
  end),
  
  signal("property::selected", function(t)
    if (not t.screen) then
      return
    end
    if (t.screen.panel) then
      t.screen.panel:set_floating(t.maximized_count == 0)
    end
  end)
}

return {
  client = function()
    return _client_signals
  end,
  tag = function()
    return _tag_signals
  end
}
