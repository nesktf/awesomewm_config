local awful     = require('awful')
local wibox     = require('wibox')
local gears     = require('gears')
local theme     = require('theme')

local host  = require('config.globals').env.host
local mod   = require('config.globals').keys.mod
-- local sound = require('widget.sound')
-- local mpris = require('widget.mpris')

local text_focus = theme.util.markdown_fg_focus

local systray = {
  timeout = 10,
  workers = {},
  tray = wibox.widget.systray(),

  reset_timer = function(self, index)
    if (self.timer ~= nil) then
      self.timer:stop()
    end

    self.timer = gears.timer { timeout = self.timeout }
    self.timer:connect_signal("timeout", function()
      self.workers[index]:set_tray_visibility(false)
    end)
    self.timer:start()
  end,

  update_screen = function(self, screen)
    for _, worker in pairs(self.workers) do
      worker:set_tray_visibility(false)
    end
    self.workers[screen.index]:set_tray_visibility(true)
    self.tray:set_screen(screen)
    -- self:reset_timer(screen.index)
  end,

  new_worker = function(self, screen)
    assert(screen ~= nil)

    local tray_holder = wibox.widget {
      widget = wibox.container.margin,
      left = 6,
      top = 2, bottom = 2,
      visible = false,
      self.tray
    }

    local show_button = wibox.widget {
      widget = wibox.widget.imagebox,
      image = theme.icon_panel_tray_open,
      visible = true,
      buttons = gears.table.join(
        awful.button({ }, 1, function() self:update_screen(awful.screen.focused()) end)
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

    self.workers[screen.index] = worker

    return worker
  end
}

local sensors = {
  workers = {},

  new_worker = function(self, arg)
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
      spacing = arg.spacing,
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
    table.insert(self.workers, widget)

    return widget
  end
}

local _M = {}

function _M.new(args)
  assert(args.screen ~= nil)
  local screen    = args.screen
  local floating  = args.floating or false
  local rounded   = args.rounded or false

  local function panel_gap(is_floating) 
    return is_floating and theme.panel_gap*2 or 0 
  end

  local function panel_shape(is_rounded)
    return is_rounded and function(cr, w, h)
      gears.shape.rounded_rect(cr, w, h, theme.panel_radius)
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
    height       = theme.panel_size,
    x            = geom.x + gap,
    y            = geom.y + gap,
    bg           = theme.panel_color,
    border_width = theme.panel_border_w,
    border_color = theme.panel_border,
    shape        = panel_shape(rounded),
  }
  widget:struts {
    top     = theme.panel_size+2*theme.panel_border_w+gap,
    bottom  = 0,
    left    = 0,
    right   = 0
  }
  widget.enable_floating = floating
  widget.enable_rounding = rounded
  widget.floating = floating
  widget.screen = screen

  function widget:toggle_floating()
    self:set_floating(not self.enable_floating)
    self.enable_floating = not self.enable_floating
    self:set_floating(self.enable_floating)
  end

  function widget:set_floating(flag)
    if (not self.enable_floating) then
      return
    end

    if (flag == self.floating) then
      return
    end

    local _geom = self.screen.geometry
    local _gap = panel_gap(flag)

    self.x     = _geom.x + _gap
    self.y     = _geom.y + _gap
    self.width = _geom.width - 2*_gap

    self:struts {
      top     = theme.panel_size+2*theme.panel_border_w+_gap,
      bottom  = 0,
      left    = 0,
      right   = 0
    }

    self.floating = flag
    self.shape = panel_shape(self.enable_rounding and self.floating)
  end

  function widget:make_tray_current()
    systray:update_screen(self.screen)
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
      -- awful.button({ }, 3, awful.tag.viewtoggle),
      -- awful.button({ mod }, 3, function(t)
      --   if client.focus then
      --       client.focus:toggle_tag(t)
      --   end
      -- end),
      awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
      awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
    ),
    layout = {
      layout = wibox.layout.fixed.horizontal,
      spacing = 0,
    },
    style = {
      bg_focus = "#00000000",
    },
    widget_template = {
      id     = 'background_role',
      widget = wibox.container.background,
      {
        widget = wibox.container.margin,
        left  = 3,
        right = 3,
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
      bg_focus = "#343133F0",
      bg_minimize = "#181B1DF0"
    },
    widget_template = {
      widget = wibox.container.margin,
      top = 5,
      bottom = 5,
      {
        layout = wibox.layout.align.vertical,
        {
          widget  = wibox.container.margin,
          left = 3,
          right = 10,
          forced_height = 18,
          forced_width = 160,
          {
            layout = wibox.layout.fixed.horizontal,
            {
              widget  = wibox.container.margin,
              right = 4,
              {
                id     = "icon_role",
                widget = wibox.widget.imagebox,
              },
            },
            {
              layout = wibox.container.scroll.horizontal,
              max_size = 160,
              step_function = wibox.container.scroll.step_functions.linear_back_and_forth,
              speed = 20,
              {
                id     = "text_role",
                widget = wibox.widget.textbox,
              },
            }
          },
        },
        -- {
        --   id            = "background_role",
        --   widget        = wibox.container.background,
        --   wibox.widget.base.make_widget(),
        -- }
      },
    },
    layout = {
      layout  = wibox.layout.fixed.horizontal,
      spacing = 6,
    },
  } 

  -- Panel setup
  widget:setup {
    layout = wibox.layout.align.horizontal,
    {
      widget = wibox.container.margin,
      left = 5,
      right = 1,
      {
        layout = wibox.layout.fixed.horizontal,
        spacing = 2,
        {
          widget = wibox.container.margin,
          top = 3,
          bottom = 3,
          {
            layout = wibox.layout.fixed.horizontal,
            layoutbox,
            {
              widget = wibox.container.margin,
              left = 3,
              right = 3,
              {
                widget = wibox.widget.separator,
                orientation = "vertical",
                forced_width = 1,
                thickness = 1,
                color = "#707070",
                span_ratio = 0.9,
              }
            },
          },
        },
        taglist,
        {
          id      = "prompt",
          widget  = wibox.widget.textbox
        },
      },
    },
    {
      layout = wibox.layout.fixed.horizontal,
      {
        widget = wibox.container.margin,
        left = 6,
        tasklist,
      }
    },
    {
      widget = wibox.container.margin,
      top = 3,
      bottom = 3,
      left = 1,
      right = 5,
      {
        layout = wibox.layout.fixed.horizontal,
        {
          widget = wibox.container.margin,
          right = 4,
          {
            layout = wibox.layout.fixed.horizontal,
            spacing = 6,
            sensors:new_worker {
              spacing = 6,
            },
            {
              layout = wibox.layout.fixed.horizontal,
              spacing = 2,
              {
                widget = wibox.widget.imagebox,
                image = theme.icon_panel_clock,
              },
              {
                widget = wibox.widget.textclock,
                format = text_focus("%H:%M"),
                -- format = fg_text("%y-%m-%d %H:%M"),
              }
            },
          },
        },
        {
          layout = wibox.layout.fixed.horizontal,
          spacing = 3,
          {
            widget = wibox.container.margin,
            left = 3,
            top = 1,
            bottom = 1,
            {
              widget = wibox.widget.separator,
              orientation = "vertical",
              forced_width = 1,
              thickness = 1,
              color = "#707070",
              span_ratio = 0.9,
            }
          },
          systray:new_worker(screen),
        }
      }
    }
  }
  return widget
end

return setmetatable({}, { __call = function(_, ...) return _M.new(...) end })
