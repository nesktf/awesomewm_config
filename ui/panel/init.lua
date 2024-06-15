local beautiful = require('beautiful')
local wibox     = require('wibox')
local gears     = require('gears')
local dpi       = require("beautiful.xresources").apply_dpi

local ui_bindings = require('binding.ui')

local rhs     = require('ui.panel.rhs')
local center  = require('ui.panel.center')
local lhs     = require('ui.panel.lhs')

local _M = {}

local function getgap(is_floating) 
  return is_floating and beautiful.panel_gap*2 or 0 
end

local function getshape(is_rounded)
  return is_rounded and function(cr, w, h)
    gears.shape.rounded_rect(cr, w, h, beautiful.panel_radius)
  end or gears.shape.rectangle
end

local function build(args)
  local screen    = args.screen or nil
  local floating  = args.floating or false
  local rounded   = args.rounded or false
  assert(screen ~= nil)

  local geom  = screen.geometry
  local gap   = getgap(floating)

  local widget = wibox {
    type    = 'dock',
    screen  = screen,
    visible = true,
    width   = dpi(geom.width - 2*gap),
    height  = beautiful.panel_size,
    x       = geom.x + gap,
    y       = geom.y + gap,
    bg      = beautiful.bg_normal,
    shape   = getshape(rounded),
  }
  widget.floating = floating
  widget.rounded  = rounded

  widget:struts {
    top     = beautiful.panel_size+gap,
    bottom  = 0,
    left    = 0,
    right   = 0
  }

  widget:setup {
    layout = wibox.layout.align.horizontal,
    lhs(
      screen,
      ui_bindings.layoutbox_buttons,
      ui_bindings.taglist_buttons
    ),
    center(
      screen,
      ui_bindings.tasklist_buttons
    ),
    rhs()
  }

  widget.set_floating = function(self, flag)
    local _geom = self.screen.geometry
    local _gap  = getgap(flag)

    self.x      = _geom.x + _gap
    self.y      = _geom.y + _gap
    self.width  = dpi(_geom.width - 2*_gap)

    self:struts {
      top     = beautiful.panel_size+_gap,
      bottom  = 0,
      left    = 0,
      right   = 0
    }

    self.floating = flag
  end

  widget.set_rounded = function(self, flag)
    self.shape    = getshape(flag)
    self.rounded  = flag
  end

  return widget
end

return setmetatable(_M, { __call = function(_, ...) return build(...) end })
