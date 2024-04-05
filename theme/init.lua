local beautiful = require("beautiful")
local gears = require("gears")
-- local wibox = require('wibox')
-- local awful = require('awful')

local awesome_dir = "~/.config/awesome"

beautiful.init(awesome_dir .. "/theme/theme.lua")

-- screen.connect_signal("request::wallpaper", function(s)
--   awful.wallpaper {
--     screen = s,
--     widget = {
--       {
--         image     = beautiful.wallpaper,
--         upscale   = true,
--         downscale = true,
--         widget    = wibox.widget.imagebox,
--       },
--       valign = "center",
--       halign = "center",
--       tiled  = false,
--       widget = wibox.container.tile,
--     }
--   }
-- end)

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end


screen.connect_signal("property::geometry", set_wallpaper)
