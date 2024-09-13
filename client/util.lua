local awful     = require('awful')
local beautiful = require('beautiful')

local titlebar = require("client.titlebar")

local _M = {}

function _M.toggle_titlebars(c)
  awful.titlebar.toggle(c, "top")
  awful.titlebar.toggle(c, "bottom")
end

function _M.toggle_tiling_borders(c)
  c.border_width = (c.border_width == beautiful.border_width)
    and beautiful.border_width_tiling
    or beautiful.border_width
end

function _M.toggle_maximized(c)
  if (c.fullscreen) then
    return
  end

  local action = function(maximized)
    if (maximized) then
      awful.titlebar.hide(c, "top")
      awful.titlebar.hide(c, "bottom")
      c.border_width = 0
    else
      titlebar.update(c)
    end
  end

  action(not c.maximized)
  c.maximized = not c.maximized
  action(c.maximized)

  c:raise()
end

function _M.toggle_fullscreen(c)
  c.fullscreen = not c.fullscreen
  c:raise()
end

return _M
