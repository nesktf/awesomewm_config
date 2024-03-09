local panel = require('layout.panel')
-- local beautiful = require('beautiful')
-- local gears = require('gears')
-- local awful = require('awful')


-- local function set_wallpaper(s)
--   -- Wallpaper
--   if beautiful.wallpaper then
--     local wallpaper = beautiful.wallpaper
--     -- If wallpaper is a function, call it with the screen
--     if type(wallpaper) == "function" then
--         wallpaper = wallpaper(s)
--     end
--     gears.wallpaper.maximized(wallpaper, s, true)
--   end
-- end

screen.connect_signal("request::desktop_decoration",
  function(s)
    s.panel = panel(s)
  end
)

-- screen.connect_signal("property::geometry", set_wallpaper)
--
-- awful.screen.connect_for_each_screen(function(s)
--   set_wallpaper(s)
--   s.panel = panel(s)
-- end)
