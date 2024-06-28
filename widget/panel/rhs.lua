local awful     = require('awful')
local wibox     = require('wibox')
local beautiful = require('beautiful')

local host = require('config.globals').env.host

local function get_temp() 
  if (host == "compy") then
    return "sensors | awk 'NR==3{printf $2}' | cut -d'+' -f2"
  elseif (host == "nobus") then
    return "sensors | awk 'NR==20{printf $3}' | cut -d'+' -f2"
  end
end

local _sensor_cmd = {
  { name = "CPU",  eval = "top -bn2 -d 0.1 | awk '/Cpu/ {print $2}' | awk 'NR==2'" },
  { name = "Temp", eval =  get_temp()},
  { name = "RAM",  eval = "printf \"%sMiB\" $(free --mebi | awk 'NR==2{printf $3}')" },
  { name = "SWAP", eval = "printf \"%sMiB\" $(free --mebi | awk 'NR==3{printf $3}')" }
}

local function build_widget(_)
  local sensorbar = { 
    layout  = wibox.layout.fixed.horizontal,
    spacing = 2,
    spacing_widget = {
      widget = wibox.container.place,
      valign = "center",
      halign = "center",
      {
        widget = wibox.widget.imagebox,
        -- image = beautiful.widget_display_c,
        -- forced_height = 23,
        -- widget        = wibox.widget.separator,
        thickness     = 1,
        color         = "#70707000",
      },
    },
  }

  for _,cmd in ipairs(_sensor_cmd) do
    local watch = awful.widget.watch(
      'bash -c "'..cmd.eval..'"', 1,
      function(widget, stdout)
        widget:set_text(stdout)
      end,
      wibox.widget{
        widget = wibox.widget.textbox,
        align = "center",
        valign = "center",
      }
    )

    local sensor = {
      layout = wibox.layout.fixed.horizontal,
      {
        widget = wibox.container.margin,
        bottom = 2,
        {
          widget = wibox.widget.imagebox,
          image = beautiful.widget_display_l
        }
      },
      {
        widget = wibox.container.background,
        bgimage = beautiful.widget_display,       
        {
          {
            widget  = wibox.widget.textbox,
            text    = cmd.name .. ":",
          },
          watch,
          spacing = 4,
          layout = wibox.layout.fixed.horizontal,
        },
      },
      {
        widget = wibox.container.margin,
        bottom = 2,
        {
          widget = wibox.widget.imagebox,
          image = beautiful.widget_display_r
        }
      },
    }
    table.insert(sensorbar, sensor)
  end

  local widget = {
    layout          = wibox.layout.fixed.horizontal,
    spacing         = 12,
    -- spacing_widget  = wibox.widget.separator,
    sensorbar,
    {
      wibox.widget.systray(),
      top = 1,
      bottom = 2,
      widget = wibox.container.margin,
    }
  }

  return widget
end

return build_widget
