local awful     = require('awful')
local wibox     = require('wibox')
local gears     = require('gears')
local beautiful = require('beautiful')

local host  = require('config.globals').env.host
local mod   = require('config.globals').keys.mod
local sound = require('widget.sound')
-- local mpris = require('widget.mpris')


local tray_manager = {
  timeout = 5,
  workers = {},
  tray = wibox.widget.systray(),
}

function tray_manager:update_screen()
  local screen = awful.screen.focused()
  for _, worker in pairs(self.workers) do
    worker:set_tray_visibility(false)
  end
  self.workers[screen.index]:set_tray_visibility(true)
  self.tray:set_screen(screen)

  if (self.timer ~= nil) then
    self.timer:stop()
  end

  self.timer = gears.timer { timeout = self.timeout }
  self.timer:connect_signal("timeout", function()
    self.workers[screen.index]:set_tray_visibility(false)
  end)
  self.timer:start()
end

function tray_manager:new_worker(screen)
  assert(screen ~= nil)

  local tray_holder = wibox.widget {
    widget = wibox.container.background,
    visible = false,
    self.tray
  }

  local button = wibox.widget {
    widget = wibox.widget.imagebox,
    image = beautiful.volume_high,
    visible = true,
    buttons = gears.table.join(
      awful.button({ }, 1, function() self:update_screen() end)
    )
  }

  local worker = wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    tray_holder,
    button,
  }

  function worker:set_tray_visibility(flag)
    tray_holder.visible = flag
    button.visible = not flag
  end

  self.workers[screen.index] = worker

  return worker
end


local function panel_button(args)
  local left = args.left or 0
  local right = args.right or 0
  local left_cont = args.left_cont or 5
  local right_cont = args.right_cont or 5
  local content = args.content
  local buttons = args.buttons

  local base = {
    widget = wibox.container.margin,
    left = left, right = right,
    top = 3, bottom = 3,
  }

  local unfocus_bg = "#292C2EF0"
  local focus_bg = "#35383AF0"
  local back = wibox.widget {
    widget = wibox.container.background,
    bg = unfocus_bg,
    shape = function(cr, w, h)
      gears.shape.rounded_rect(cr, w, h, 2)
    end,
    {
      widget = wibox.container.margin,
      left = left_cont,
      right = right_cont,
      content
    }
  }

  if (buttons) then
    back:buttons(buttons)
    back:connect_signal("mouse::enter", function()
      back.bg = focus_bg
    end)
    back:connect_signal("mouse::leave", function()
      back.bg = unfocus_bg
    end)
  end
  table.insert(base, back)

  return base
end


local function __build_panel(args)
  assert(args.screen ~= nil)
  local screen    = args.screen
  local floating  = args.floating or false
  local rounded   = args.rounded or false

  local function panel_gap(is_floating) 
    return is_floating and beautiful.panel_gap*2 or 0 
  end

  local function panel_shape(is_rounded)
    return is_rounded and function(cr, w, h)
      gears.shape.rounded_rect(cr, w, h, beautiful.panel_radius)
    end or gears.shape.rectangle
  end

  local geom  = screen.geometry
  local gap   = panel_gap(floating)

  -- Panel settings
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
    shape        = panel_shape(rounded),
  }
  widget:struts {
    top     = beautiful.panel_size+2*beautiful.panel_border_w+gap,
    bottom  = 0,
    left    = 0,
    right   = 0
  }
  widget.floating = floating
  widget.rounded = rounded

  function widget:set_floating(flag)
    if (flag == self.floating) then return end

    local _geom = self.screen.geometry
    local _gap = panel_gap(flag)

    self.x     = _geom.x + _gap
    self.y     = _geom.y + _gap
    self.width = _geom.width - 2*_gap

    self:struts {
      top     = beautiful.panel_size+2*beautiful.panel_border_w+_gap,
      bottom  = 0,
      left    = 0,
      right   = 0
    }

    self.floating = flag
  end

  function widget:set_rounded(flag)
    if (flag == self.rounded) then return end

    self.shape = panel_shape(flag)
    self.rounded = flag
  end

  -- Taglist
  local taglist = awful.widget.taglist {
    screen  = screen,
    filter  = awful.widget.taglist.filter.all,
    buttons = gears.table.join(
      awful.button({ }, 1, function(t) t:view_only() end),
      awful.button({ mod }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
      end),
      awful.button({ }, 3, awful.tag.viewtoggle),
      awful.button({ mod }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
      end),
      awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end),
      awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end)
    ),
    layout = {
      layout = wibox.layout.fixed.horizontal,
      spacing = 4,
    },
    style = {
      bg_focus = "#393C3EF0",
    },
    widget_template = {
      id     = 'background_role',
      widget = wibox.container.background,
      {
        widget = wibox.container.margin,
        left  = 4,
        right = 7,
        {
          layout = wibox.layout.fixed.horizontal,
          {
            margins = 2,
            widget  = wibox.container.margin,
            {
              id     = 'icon_role',
              widget = wibox.widget.imagebox,
            },
          },
          {
            id     = 'text_role',
            widget = wibox.widget.textbox,
          },
        },
      },
    },
  }

  -- Layoutbox
  local layoutbox = awful.widget.layoutbox(screen)
  layoutbox:buttons(gears.table.join(
    awful.button({ }, 1, function() awful.layout.inc( 1) end),
    awful.button({ }, 3, function() awful.layout.inc(-1) end),
    awful.button({ }, 4, function() awful.layout.inc( 1) end),
    awful.button({ }, 5, function() awful.layout.inc(-1) end)
  ))

  -- Tasklist
  local tasklist = awful.widget.tasklist {
    screen  = screen,
    filter  = awful.widget.tasklist.filter.currenttags,
    buttons = gears.table.join(
      awful.button({ }, 1, function (c)
        if c == client.focus then
          c.minimized = true
        else
          c:emit_signal("request::activate", "tasklist", {raise = true})
        end
      end),
      awful.button({ }, 3, function() awful.menu.client_list({ theme = { width = 250 } })end),
      awful.button({ }, 4, function() awful.client.focus.byidx(1) end),
      awful.button({ }, 5, function() awful.client.focus.byidx(-1) end)
    ),
    style = {
      shape = function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, 2)
      end,
      bg_normal = "#202426F0",
      bg_focus = "#292C2EF0",
      bg_minimize = "#181B1DF0"
    },
    widget_template = {
      widget = wibox.container.margin,
      top = 3, bottom = 3,
      right = 6,
      {
        id            = "background_role",
        widget        = wibox.container.background,
        forced_width = 180,
        {
          widget  = wibox.container.margin,
          left    = 3,
          right   = 10,
          {
            layout = wibox.layout.fixed.horizontal,
            {
              widget  = wibox.container.margin,
              top = 1, bottom = 1,
              right = 3,
              {
                id     = "icon_role",
                widget = wibox.widget.imagebox,
              },
            },
            -- {
              -- widget = wibox.container.constraint,
              -- width = 180,
              -- strategy = "max",
              {
                id     = "text_role",
                widget = wibox.widget.textbox,
              },
            -- }
          },
        },
      }
    },
    layout = {
      layout  = wibox.layout.fixed.horizontal,
      spacing = 0,
    },
  } 

  -- Sensorbar
  local function get_temp() 
    if (host == "compy") then
      return "sensors | awk 'NR==3{printf $2}' | cut -d'+' -f2"
    elseif (host == "nobus") then
      return "sensors | awk 'NR==20{printf $3}' | cut -d'+' -f2"
    end
  end
  local sensor_cmd = {
    { name = "CPU",  eval = "top -bn2 -d 0.1 | awk '/Cpu/ {print $2}' | awk 'NR==2{print $1\\\"%\\\"}'" },
    { name = "Temp", eval =  get_temp()},
    { name = "RAM",  eval = "printf \"%sMiB\" $(free --mebi | awk 'NR==2{printf $3}')" },
    { name = "SWAP", eval = "printf \"%sMiB\" $(free --mebi | awk 'NR==3{printf $3}')" }
  }
  local sensorbar = { 
    layout  = wibox.layout.fixed.horizontal,
    spacing = 6,
  }
  for _,cmd in ipairs(sensor_cmd) do
    local watch = awful.widget.watch(
      'bash -c "'..cmd.eval..'"', 1,
      function(w, stdout)
        w:set_text(stdout)
      end,
      wibox.widget{
        widget = wibox.widget.textbox,
        align = "center",
        valign = "center",
      }
    )

    local sensor = panel_button {
      content = {
        {
          widget  = wibox.widget.textbox,
          text    = cmd.name,
        },
        watch,
        spacing = 5,
        layout = wibox.layout.fixed.horizontal,
      }
    }
    table.insert(sensorbar, sensor)
  end

  -- Panel setup
  widget:setup {
    layout = wibox.layout.align.horizontal,
    {
      layout = wibox.layout.fixed.horizontal,
      spacing = 6,
      panel_button {
        left = 5,
        content = wibox.widget.textclock()
      },
      panel_button {
        content = taglist,
      },
      {
        id      = "prompt",
        widget  = wibox.widget.textbox
      },
    },
    tasklist,
    {
      layout = wibox.layout.fixed.horizontal,
      spacing = 6,
      sensorbar,
      -- panel_button {
      --   content = mpris.new_worker{},
      --   buttons = gears.table.join(
      --     awful.button({ }, 2, function() mpris.toggle_pause() end),
      --     awful.button({ }, 4, function() mpris.step_volume(0.05) end),
      --     awful.button({ }, 5, function() mpris.step_volume(-0.05) end)
      --   )
      -- },
      panel_button {
        right = 5,
        content = {
          layout = wibox.layout.fixed.horizontal,
          {
            widget = wibox.container.margin,
            right = 1, top = 1, bottom = 1, left = 1,
            {
              layout = wibox.layout.fixed.horizontal,
              spacing = 5,
              layoutbox,
              {
                widget = sound.new_worker(),
                buttons = gears.table.join(
                  awful.button({ }, 4, function() sound.step_volume(0.05) end),
                  awful.button({ }, 5, function() sound.step_volume(-0.05) end)
                )
              },
              tray_manager:new_worker(screen),
            },
          },
        }
      },
    },
  }
  return widget
end

return setmetatable({}, { __call = function(_, ...) return __build_panel(...) end })
