local gears = require('gears')
local beautiful = require('beautiful')
local wibox = require('wibox') 
local mouse = mouse

local theme_dir = require('config.const').path.theme_dir
local icon_dir = theme_dir .. "/icons/"

local _M = {}

_M.icons = {
  volume_low = icon_dir .. "audio-volume-low.png",
  volume_medium = icon_dir .. "audio-volume-medium.png",
  volume_high = icon_dir .. "audio-volume-high.png",
  volume_muted = icon_dir .. "audio-volume-muted.png",
}

_M.preview_wbox = wibox({
  width = 230,
  height = 40,
  -- border_width = 1,
  ontop = true,
  visible = false,
  bg = beautiful.titlebar_bg_focus,
  shape = function(cr, w, h)
    gears.shape.rounded_rect(cr, w, h, 10)
  end
})

_M.timer = nil

local function __volume_horizontal(vol)
  local vol_str = tostring(math.floor(vol*100))

  local function map_icon(_vol)
    if (_vol > 0.66) then
      return _M.icons.volume_high
    elseif (_vol > 0.33) then
      return _M.icons.volume_medium
    elseif (_vol > 0) then
      return _M.icons.volume_low
    else
      return _M.icons.volume_muted
    end
  end

  local widget = wibox.widget {
    {
      {
        image = map_icon(vol),
        resize = true,
        widget = wibox.widget.imagebox
      },
      margins = 5,
      widget = wibox.container.margin
    },
    {
      {
        max_value = 1,
        value = vol > 1 and 1 or vol,
        forced_height = 6,
        forced_width = 150,
        color = "#A0A0A0",
        background_color = "#000000",
        widget = wibox.widget.progressbar
      },
      widget = wibox.container.place
    },
    {
      text = vol_str .. "%",
      align = "center",
      widget = wibox.widget.textbox
    },
    layout = wibox.layout.ratio.horizontal
  }
  widget:ajust_ratio(2, 0.2, 0.6, 0.2)
  return widget
end

_M.volumebar_h = function(params) 
  local geom = screen[mouse.screen].geometry

  local w = _M.preview_wbox.width
  local h = _M.preview_wbox.height
  local offset = params.offset == nil and math.floor(geom.height*0.25) or params.offset
  local vol = params.vol

  _M.preview_wbox:geometry({
    x = geom.x + (geom.width - w) * 0.5, -- Half of the screen
    y = geom.y + (geom.height - h + offset) * 0.5,
  })
  _M.preview_wbox:set_widget(__volume_horizontal(vol))
  _M.preview_wbox.visible = true

  if (_M.timer ~= nil) then _M.timer:stop() end
  _M.timer = gears.timer({timeout = 1})
  _M.timer:connect_signal("timeout", function()
    _M.timer:stop()
    _M.preview_wbox.visible = false
  end)
  _M.timer:start()
end

return {volumebar_h = _M.volumebar_h}
