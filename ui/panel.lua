local awful   = require('awful')
local wibox   = require('wibox')

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
    widget = wibox.layout.fixed.horizontal
  }

  for i,item in ipairs(cmd) do
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
    if (i ~= #cmd) then
      col:add(wibox.widget {
        text = "|",
        widget = wibox.widget.textbox
      })
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
 -- local panel = wibox {
  --   ontop = true,
  --   screen = s,
  --   type = 'dock',
  --   height = dpi(24),
  --   width = s.geometry.width, 
  --   x = s.geometry.x,
  --   y = s.geometry.y,
  --   stretch = false,
  --   bg = beautiful.background,
  --   fg = beautiful.fg_normal
  -- }
  local panel = awful.wibar({
    screen = screen,
    position = "top",
  })

  panel:setup {
    {
     wibox.widget.textclock(),
      _M.taglist(screen),
      awful.widget.prompt(),
      layout = wibox.layout.fixed.horizontal,
      spacing = 12,
      spacing_widget = {
        widget = wibox.widget.separator
      },
    },
    _M.tasklist(screen),
    {
       _M.sensor_bar(),
      {
        wibox.widget.systray(),
        _M.layoutbox(screen),
        spacing = 6,
        layout = wibox.layout.fixed.horizontal,
      },
      spacing = 12,
      spacing_widget = wibox.widget.separator,
      layout = wibox.layout.fixed.horizontal,
    },
    layout = wibox.layout.align.horizontal,
  }
end

return {setup = _M.setup}
