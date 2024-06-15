local awful     = require('awful')
local wibox     = require('wibox')
local beautiful = require('beautiful')

local _sensor_cmd = {
  { name = "CPU",  eval = "top -bn2 -d 0.1 | awk '/Cpu/ {print $2}' | awk 'NR==2'" },
  { name = "Temp", eval = "sensors | awk 'NR==10{printf $4}' | cut -d'+' -f2" },
  { name = "RAM",  eval = "printf \"%sMiB\" $(free --mebi | awk 'NR==2{printf $3}')" },
  { name = "SWAP", eval = "printf \"%sMiB\" $(free --mebi | awk 'NR==3{printf $3}')" }
}

local function build_widget(_)
  local sensorbar = { 
    layout  = wibox.layout.fixed.horizontal,
    spacing = 10,
    spacing_widget = {
      widget = wibox.container.place,
      valign = "center",
      halign = "center",
      {
        widget        = wibox.widget.separator,
        forced_height = beautiful.panel_size - 8,
        thickness     = 1,
        color         = "#707070",
      },
    },
  }

  for _,cmd in ipairs(_sensor_cmd) do
    local sensor = {
      layout  = wibox.layout.fixed.horizontal,
      spacing = 2,
      {
        widget  = wibox.widget.textbox,
        text    = cmd.name .. ":",
      },
      {
        awful.widget.watch('bash -c "' .. cmd.eval .. '"', 1), 
        layout = wibox.layout.fixed.horizontal,
      },
    }
    table.insert(sensorbar, sensor)
  end

  local widget = {
    layout          = wibox.layout.fixed.horizontal,
    spacing         = 12,
    spacing_widget  = wibox.widget.separator,
    sensorbar,
    wibox.widget.systray(),
  }

  return widget
end

return build_widget
