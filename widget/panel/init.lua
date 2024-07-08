local beautiful = require('beautiful')
local wibox     = require('wibox')
local gears     = require('gears')

local rhs     = require('widget.panel.rhs')
local center  = require('widget.panel.center')
local lhs     = require('widget.panel.lhs')

local _M = {}

local function _getgap(is_floating) 
  return is_floating and beautiful.panel_gap*2 or 0 
end

local function _getshape(is_rounded)
  return is_rounded and function(cr, w, h)
    gears.shape.rounded_rect(cr, w, h, beautiful.panel_radius)
  end or gears.shape.rectangle
end

local function __build_widget(args)
  assert(args.screen ~= nil)
  local screen    = args.screen
  local floating  = args.floating or false
  local rounded   = args.rounded or false

  local geom  = screen.geometry
  local gap   = _getgap(floating)

  local widget = wibox {
    type         = 'dock',
    screen       = screen,
    visible      = true,
    width        = geom.width - 2*gap,
    height       = beautiful.panel_size,
    x            = geom.x + gap,
    y            = geom.y + gap,
    bg           = beautiful.panel_color,
    border_width = beautiful.panel_border_w,
    border_color = beautiful.panel_border,
    shape   = _getshape(rounded),
  }
  widget.floating = floating
  widget.rounded  = rounded

  widget:struts {
    top     = beautiful.panel_size+2*beautiful.panel_border_w+gap,
    bottom  = 0,
    left    = 0,
    right   = 0
  }

  widget:setup {
    layout = wibox.layout.align.horizontal,
    lhs(screen),
    center(screen),
    rhs(screen)
  }

  widget.set_floating = function(self, flag)
    local _geom = self.screen.geometry
    local _gap  = _getgap(flag)

    self.x      = _geom.x + _gap
    self.y      = _geom.y + _gap
    self.width  = _geom.width - 2*_gap

    self:struts {
      top     = beautiful.panel_size+2*beautiful.panel_border_w+_gap,
      bottom  = 0,
      left    = 0,
      right   = 0
    }

    self.floating = flag
  end

  widget.set_rounded = function(self, flag)
    self.shape    = _getshape(flag)
    self.rounded  = flag
  end

  return widget
end

return setmetatable(_M, { __call = function(_, ...) return __build_widget(...) end })
