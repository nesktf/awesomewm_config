local beautiful = require("beautiful")
local wibox = require('wibox')
local awful = require('awful')

local awesome_dir = "~/.config/awesome"

beautiful.init(awesome_dir .. "/theme/theme.lua")

screen.connect_signal("request::wallpaper", function(s)
  awful.wallpaper {
    screen = s,
    widget = {
      {
        image     = beautiful.wallpaper,
        upscale   = true,
        downscale = true,
        widget    = wibox.widget.imagebox,
      },
      valign = "center",
      halign = "center",
      tiled  = false,
      widget = wibox.container.tile,
    }
  }
end)


