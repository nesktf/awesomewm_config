local awful = require("awful")
local wibox = require("wibox")

local sensor_items = {
  { name = "CPU",  eval = "top -bn2 -d 0.1 | awk '/Cpu/ {print $2}' | awk 'NR==2'" },
  { name = "Temp", eval = "sensors | awk 'NR==10{printf $4}' | cut -d'+' -f2" },
  { name = "RAM",  eval = "printf \"%sMiB\" $(free --mebi | awk 'NR==2{printf $3}')" },
  { name = "SWAP", eval = "printf \"%sMiB\" $(free --mebi | awk 'NR==3{printf $3}')" }
}

local sensor_bar = wibox.widget {
  spacing = 4,
  widget = wibox.layout.fixed.horizontal
}

for i,item in ipairs(sensor_items) do
  local col = wibox.widget {
    {
      text = item.name .. ":",
      widget = wibox.widget.textbox
    },
    {
      widget = awful.widget.watch('bash -c "' .. item.eval .. '"', 1)
    },
    spacing = 2,
    widget = wibox.layout.fixed.horizontal
  }
  if (i ~= #sensor_items) then
    col:add(wibox.widget {
      text = "|",
      widget = wibox.widget.textbox
    })
  end
  sensor_bar:add(col)
end

return sensor_bar
