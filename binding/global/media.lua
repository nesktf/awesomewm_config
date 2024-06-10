local awful   = require('awful')
local gears   = require('gears')

local modkey  = require('main.globals').keys.mod
local osd     = require('ui.osd')

local function show_volume()
  local cmd = "amixer -D pulse get Master | awk -F 'Left:|[][]' 'BEGIN {RS=\"\"}{ gsub(\"%\",\"\"); if ($5==\"on\") { print $3 } else { print \"0\" } }'"
  awful.spawn.easy_async_with_shell(cmd, function(out)
    osd.volumebar_h({vol = tonumber(out)*0.01})
  end)
end

local media_bindings = gears.table.join(
  awful.key({ modkey }, "F1",
    function()
      awful.spawn.with_shell("pactl set-sink-volume @DEFAULT_SINK@ -1.328252939dB")
      show_volume()
    end,
    {description = "lower volume", group = "media"}
  ),

  awful.key({ modkey }, "F2",
    function()
      awful.spawn.with_shell("pactl set-sink-volume @DEFAULT_SINK@ +1.328252939dB")
      show_volume()
    end,
    {description = "raise volume", group = "media"}
  ),


  awful.key({ modkey }, "F3",
    function()
      awful.spawn.with_shell("pactl set-sink-mute @DEFAULT_SINK@ toggle")
      show_volume()
    end,
    {description = "toggle mute volume", group = "media"}
  ),

  awful.key({ modkey }, "F4",
    function()
      awful.spawn.with_shell("amixer -D pulse sset Master 75%,55%")
      show_volume()
    end,
    {description = "reset volume", group = "media"}
  )
)

return media_bindings
