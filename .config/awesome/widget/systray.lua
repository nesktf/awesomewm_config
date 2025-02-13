local awful     = require('awful')
local wibox     = require('wibox')
local gears     = require('gears')
local theme     = require('theme')

local _systray = {
  timeout = 10,
  workers = {},
  tray = wibox.widget.systray(),
}

function _systray:reset_timer(index)
  if (self.timer ~= nil) then
    self.timer:stop()
  end

  self.timer = gears.timer { timeout = self.timeout }
  self.timer:connect_signal("timeout", function()
    self.workers[index]:set_tray_visibility(false)
  end)
  self.timer:start()
end


local _M = {}

function _M.update_screen(screen)
  for _, worker in pairs(_systray.workers) do
    worker:set_tray_visibility(false)
  end
  _systray.workers[screen.index]:set_tray_visibility(true)
  _systray.tray:set_screen(screen)
  -- self:reset_timer(screen.index)
end

function _M.new(args)
  local screen = assert(args.screen)

  local tray_holder = wibox.widget {
    widget = wibox.container.margin,
    left = 6,
    top = 2, bottom = 2,
    visible = false,
    _systray.tray
  }

  local show_button = wibox.widget {
    widget = wibox.widget.imagebox,
    image = theme.icon_panel_tray_open,
    visible = true,
    buttons = gears.table.join(
      awful.button({ }, 1, function()
        _M.update_screen(awful.screen.focused())
      end)
    )
  }

  local hide_button
  hide_button = wibox.widget {
    widget = wibox.widget.imagebox,
    image = theme.icon_panel_tray_close,
    visible = false,
    buttons = gears.table.join(
      awful.button({ }, 1, function()
        hide_button.visible = false
        tray_holder.visible = false
        show_button.visible = true
      end)
    )
  }

  local worker = wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    tray_holder,
    show_button,
    {
      widget = wibox.container.margin,
      left = 5,
      hide_button
    },
  }

  function worker:set_tray_visibility(flag)
    tray_holder.visible = flag
    hide_button.visible = flag
    show_button.visible = not flag
  end

  _systray.workers[screen.index] = worker

  return worker
end

return setmetatable(_M, { __call = function(_, ...) return _M.new(...) end})
