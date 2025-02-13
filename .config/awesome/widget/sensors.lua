local awful     = require('awful')
local wibox     = require('wibox')
local theme     = require('theme')

local host       = require('config.globals').env.host
local text_focus = theme.util.markdown_fg_focus

local _sensors = {
  workers = {},
}

local _M = {}

function _M.new(args)
  local sensor_cmd = {
    {
      icon = theme.icon_panel_cpu,
      eval = "top -bn2 -d 0.1 | awk '/Cpu/ {print $2}' | awk 'NR==2{print $1\\\"%\\\"}'",
    },
    {
      icon = theme.icon_panel_temp,
      eval = (function()
        if (host == "compy") then
          return "sensors | awk 'NR==3{printf $2}' | cut -d'+' -f2"
        elseif (host == "nobus") then
          return "sensors | awk 'NR==20{printf $3}' | cut -d'+' -f2"
        end
      end)(),
    },
    {
      icon = theme.icon_panel_ram,
      eval = "printf \"%sMiB\" $(free --mebi | awk 'NR==2{printf $3}')"
    },
    {
      icon = theme.icon_panel_swap,
      eval = "printf \"%sMiB\" $(free --mebi | awk 'NR==3{printf $3}')" 
    }
  }

  local sensorbar = { 
    layout  = wibox.layout.fixed.horizontal,
    spacing = args.spacing,
  }
  for _,cmd in ipairs(sensor_cmd) do
    local watch = awful.widget.watch(
      'bash -c "'..cmd.eval..'"', 1,
      function(w, stdout)
        w:set_markup_silently(text_focus(stdout))
      end,
      wibox.widget{
        widget = wibox.widget.textbox,
        align = "center",
        valign = "center",
      }
    )
    local sensor = {
      layout = wibox.layout.fixed.horizontal,
      spacing = 2,
      {
        widget = wibox.widget.imagebox,
        image = cmd.icon,
        -- widget  = wibox.widget.textbox,
        -- markup = string.format([[<b>%s</b>]], cmd.name)
        -- text    = cmd.name,
      },
      watch,
    }
    table.insert(sensorbar, sensor)
  end

  local widget = wibox.widget(sensorbar)
  table.insert(_sensors.workers, widget)

  return widget
end

return setmetatable(_M, { __call = function(_, ...) return _M.new(...) end })
