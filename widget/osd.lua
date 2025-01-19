local wibox     = require('wibox') 
local gears     = require('gears')
local beautiful = require('beautiful')

local _osd = {
  -- timer = nil,
  wibox = wibox {
    width   = 230,
    height  = 40,
    ontop   = true,
    visible = false,
    bg      = beautiful.titlebar_bg_focus,
  },
}

local function default_offset(screen)
  return math.floor(screen.geometry.height*0.25)
end

function _osd:show_wibox(timeout)
  self.wibox.visible = true

  if (self.timer ~= nil) then 
    self.timer:stop() 
  end

  self.timer = gears.timer { timeout = timeout }
  self.timer:connect_signal("timeout", function()
    self.timer:stop()
    self.wibox.visible = false
  end)
  self.timer:start()
end

function _osd:show_progress(args)
  assert(args.screen ~= nil)
  local screen  = args.screen
  local value   = args.value or 0
  local offset  = args.offset or default_offset(screen)
  local timeout = args.timeout or 2
  local icon    = args.icon or ""

  local widget = wibox.widget {
    layout = wibox.layout.ratio.horizontal,
    {
      widget  = wibox.container.margin,
      margins = 5,
      {
        widget = wibox.widget.imagebox,
        image  = icon,
        resize = true,
      },
    },
    {
      widget = wibox.container.place,
      {
        widget           = wibox.widget.progressbar,
        value            = value > 1 and 1 or (args.value < 0 and 0 or args.value),
        max_value        = 1,
        forced_height    = 6,
        forced_width     = 200,
        color            = "#A0A0A0",
        background_color = "#000000"
      },
    },
    {
      widget = wibox.widget.textbox,
      text   = tostring(math.floor(value*100)).."%",
      align  = "center",
    }
  }
  if (icon == "") then
    widget:ajust_ratio(2, 0.05, 0.77, 0.18)
  else
    widget:ajust_ratio(2, 0.2, 0.62, 0.18)
  end

  local geom = screen.geometry
  self.wibox:geometry {
    x = geom.x + (geom.width - _osd.wibox.width) * 0.5,
    y = geom.y + (geom.height - _osd.wibox.height + offset) * 0.5,
  }
  self.wibox:set_widget(widget)

  self:show_wibox(timeout)
end

function _osd:show_text(args)
  assert(args.screen ~= nil)
  local screen  = args.screen
  local text    = args.text or ""
  local offset  = args.offset or default_offset(screen)
  local timeout = args.timeot or 1
  local icon    = args.icon or ""

  local widget = wibox.widget {
    layout = wibox.layout.ratio.horizontal,
    {
      widget  = wibox.container.margin,
      margins = 5,
      {
        widget = wibox.widget.imagebox,
        image  = icon,
        resize = true,
      },
    },
    {
      widget = wibox.widget.textbox,
      text   = text,
      align  = "center",
    }
  }

  if (icon == "") then
    widget:ajust_ratio(2, 0, 1, 0)
  else
    widget:ajust_ratio(2, 0.2, 0.8, 0)
  end

  local geom = screen.geometry
  self.wibox:geometry {
    x = geom.x + (geom.width - _osd.wibox.width) * 0.5,
    y = geom.y + (geom.height - _osd.wibox.height + offset) * 0.5,
  }
  self.wibox:set_widget(widget)

  self:show_wibox(timeout)
end

return {
  progress = function(args)
    _osd:show_progress(args)
  end,
  text = function(args)
    _osd:show_text(args)
  end,
}
