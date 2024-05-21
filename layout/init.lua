-- Layout

local awful = require('awful')
local beautiful = require("beautiful")
local gears = require("gears")

-- Enabled Layouts
awful.layout.layouts = {
    awful.layout.suit.tile.left,
    awful.layout.suit.tile,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.floating,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
}

-- Theme things
local awesome_dir = "~/.config/awesome"
beautiful.init(awesome_dir .. "/theme/theme.lua")

-- Wallpaper
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

-- Panel
local panel = require('layout.panel')

-- Bind panel & wallpaper
awful.screen.connect_for_each_screen(function(s)
  set_wallpaper(s)
  s.panel = panel(s)
end)
