local gears     = require("gears")
local beautiful = require("beautiful")

local _M = {}

function _M.apply_pape(screen)
  assert(screen ~= nil)

  local wallpaper = beautiful.wallpaper
  if (wallpaper) then
    if (type(wallpaper) == "function") then
      wallpaper = wallpaper(screen)
    end
    gears.wallpaper.maximized(wallpaper, screen, false)
  end
end

return _M
