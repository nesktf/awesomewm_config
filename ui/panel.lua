local awful     = require('awful')
local wibox     = require('wibox')
local gears     = require('gears')
local beautiful = require('beautiful')
local dpi       = require("beautiful.xresources").apply_dpi

local ui_bindings = require('binding.ui')

local _M = {}

_M.sensor_bar = function()
  local cmd = {
    { name = "CPU",  eval = "top -bn2 -d 0.1 | awk '/Cpu/ {print $2}' | awk 'NR==2'" },
    { name = "Temp", eval = "sensors | awk 'NR==10{printf $4}' | cut -d'+' -f2" },
    { name = "RAM",  eval = "printf \"%sMiB\" $(free --mebi | awk 'NR==2{printf $3}')" },
    { name = "SWAP", eval = "printf \"%sMiB\" $(free --mebi | awk 'NR==3{printf $3}')" }
  }
  local widget = wibox.widget {
    spacing = 4,
    layout = wibox.layout.fixed.horizontal, 
   }

  for i,item in ipairs(cmd) do
    local col = wibox.widget({
      {
        text = item.name .. ":",
        widget = wibox.widget.textbox,
      },
      awful.widget.watch('bash -c "' .. item.eval .. '"', 1),
      spacing = 2,
      layout = wibox.layout.fixed.horizontal,
      bg = beautiful.bg_focus,
      widget = wibox.container.background,
    })
    if (i ~= #cmd) then
      col:add(wibox.widget({
        text = "|",
        widget = wibox.widget.textbox,
      }))
    end
    widget:add(col)
  end
  return widget
end

_M.taglist = function(screen)
  awful.tag({ "1", "2", "3", "4" }, screen, awful.layout.layouts[1])
  local widget = awful.widget.taglist {
    screen  = screen,
    filter  = awful.widget.taglist.filter.all,
    buttons = ui_bindings.taglist_buttons,
  }
  return widget
end

_M.tasklist = function(screen)
  local widget = awful.widget.tasklist {
    screen  = screen,
    filter  = awful.widget.tasklist.filter.currenttags,
    buttons = ui_bindings.tasklist_buttons,
    widget_template = {
      {
        {
          {
            {
              id     = "icon_role",
              widget = wibox.widget.imagebox,
            },
            margins = 2,
            widget  = wibox.container.margin,
          },
          {
            id     = "text_role",
            widget = wibox.widget.textbox,
          },
          layout = wibox.layout.fixed.horizontal,
        },
        left  = 0,
        right = 10,
        widget = wibox.container.margin
      },
      id     = "background_role",
      widget = wibox.container.background,
    },
    layout = {
      spacing_widget = {
        {
          forced_width  = 5,
          forced_height = 24,
          thickness     = 1,
          color         = "#777777",
          widget        = wibox.widget.separator
        },
        valign = "center",
        halign = "center",
        widget = wibox.container.place,
      },
      spacing = 1,
      layout  = wibox.layout.fixed.horizontal
    },
  }
  return widget
end

_M.layoutbox = function(screen)
  local widget = awful.widget.layoutbox(screen)
  widget:buttons(ui_bindings.layoutbox_buttons)
  return widget
end

_M.setup = function(screen)
  local geom = screen.geometry
  local gap = beautiful.useless_gap*2
  local panel = wibox({
    type    = 'dock',
    screen  = screen,
    visible = true,
    width   = dpi(geom.width - 2*gap),
    height  = beautiful.panel_size,
    x       = geom.x + gap,
    y       = geom.y + gap,
    bg      = beautiful.bg_normal,
    shape = function(cr, w, h)
      gears.shape.rounded_rect(cr, w, h, 4)
    end
  })

  panel:struts({
    top     = beautiful.panel_size+gap,
    bottom  = 0,
    left    = 0,
    right   = 0
  })

  panel:setup({
    { -- Left
      wibox.widget.textclock(),
      {
        _M.taglist(screen),
        _M.layoutbox(screen),
        spacing = 8,
        layout = wibox.layout.fixed.horizontal,
      },
      awful.widget.prompt(),
      spacing = 12,
      spacing_widget = wibox.widget.separator,
      layout = wibox.layout.fixed.horizontal,
    },
    { -- Center
      _M.tasklist(screen),
      layout = wibox.layout.fixed.horizontal,
    },
    { -- Right
      _M.sensor_bar(),
      wibox.widget.systray(),
      spacing = 12,
      spacing_widget = wibox.widget.separator,
      layout = wibox.layout.fixed.horizontal,
    },
    layout = wibox.layout.align.horizontal,
  })
end

return {setup = _M.setup}
