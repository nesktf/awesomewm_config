local awful = require('awful')
local gears = require('gears')
local naughty = require('naughty')
local modkey = require('config.bindings.mod').mod_key

local media_bindings = gears.table.join(
  awful.key({ modkey }, "F1",
    function()
      awful.spawn.with_shell("pactl set-sink-volume @DEFAULT_SINK@ -1.328252939dB")
    end,
    {description = "lower volume", group = "media"}
  ),

  awful.key({ modkey }, "F2",
    function()
      awful.spawn.with_shell("pactl set-sink-volume @DEFAULT_SINK@ +1.328252939dB")
    end,
    {description = "raise volume", group = "media"}
  ),


  awful.key({ modkey }, "F3",
    function()
      local command = "sleep 0.09 ; pactl list sinks | grep Volume | grep -oaE '..[0-9]%' | awk 'FNR == 1 {print}'"
      awful.spawn.easy_async_with_shell(command, function(out)
        naughty.notify({
          text = out,
          timeout = 1,
          position = "bottom_middle",
          replaces_id = 1,
          width = 500,
          height = 500
        })
      end)
      -- awful.spawn.with_shell("pactl set-sink-mute @DEFAULT_SINK@ toggle")
    end,
    {description = "toggle mute volume", group = "media"}
  ),

  awful.key({ modkey }, "F4",
    function()
      awful.spawn.with_shell("amixer -D pulse sset Master 100%,75%")
    end,
    {description = "reset volume", group = "media"}
  )
)

return media_bindings
