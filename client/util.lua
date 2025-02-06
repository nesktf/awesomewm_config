local awful     = require('awful')
local theme     = require('theme')

local function set_titlebar(c, toggle)
  if (c.requests_no_titlebar) then
    return
  end

  if (toggle) then
    awful.titlebar.show(c, "top")
    awful.titlebar.show(c, "bottom")
  else
    awful.titlebar.hide(c, "top")
    awful.titlebar.hide(c, "bottom")
  end
end

local function update_titlebar(c, max)
  local maximized = max or c.maximized
  if (not maximized) then
    local floating = c.floating or (c.first_tag ~= nil and c.first_tag.layout.name == "floating")

    if (floating) then
      set_titlebar(c, true)
      c.border_width = theme.border_width
    else
      set_titlebar(c, false)
      c.border_width = theme.border_width_tiling
    end
  else
    set_titlebar(c, false)
    c.border_width = 0
  end
end

return {
  set_titlebar = set_titlebar,
  update_titlebar = update_titlebar,
  toggle_titlebar = function(c)
    awful.titlebar.toggle(c, "top")
    awful.titlebar.toggle(c, "bottom")
  end,
  toggle_borders = function(c)
    c.border_width = (c.border_width == theme.border_width)
      and theme.border_width_tiling
      or theme.border_width
  end,

  toggle_maximize = function(c)
    if (c.fullscreen) then
      return
    end

    local t = c.first_tag
    if (not c.maximized) then
      t.maximized_count = t.maximized_count+1
      update_titlebar(c, true)
    else
      t.maximized_count = t.maximized_count-1
    end
    c.screen.panel:set_floating(t.maximized_count == 0)

    -- require("naughty").notify{text = string.format("sz: %d %d", c.width, c.height)}
    c.maximized = not c.maximized
  end,

  toggle_fullscreen = function(c)
    c.fullscreen = not c.fullscreen
  end,
}
