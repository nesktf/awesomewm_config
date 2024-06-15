local awful     = require('awful')
local gears     = require('gears')
local beautiful = require('beautiful')

local modkey  = require('main.globals').keys.mod
local osd     = require('widget.osd')

local function vol_icon(_vol)
  if (_vol > 0.66) then
    return beautiful.volume_high
  elseif (_vol > 0.33) then
    return beautiful.volume_medium
  elseif (_vol > 0) then
    return beautiful.volume_low
  else
    return beautiful.volume_mute
  end
end

local function show_volume()
  local cmd = "amixer -D pulse get Master | awk -F 'Left:|[][]' 'BEGIN {RS=\"\"}{ gsub(\"%\",\"\"); if ($5==\"on\") { print $3 } else { print \"0\" } }'"
  awful.spawn.easy_async_with_shell(cmd, function(out)
    local vol = tonumber(out)*0.01
    osd.progress {
      screen = awful.screen.focused(),
      value  = vol,
      icon   = vol_icon(vol)
    }
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
      awful.spawn.with_shell("amixer -D pulse sset Master 80%,57%")
      osd.text {
        screen = awful.screen.focused(),
        text = "Volume balance reset",
        icon = vol_icon(0.5)
      }
    end,
    {description = "reset volume", group = "media"}
  )
)

return media_bindings
