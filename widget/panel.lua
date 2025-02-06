local awful     = require('awful')
local wibox     = require('wibox')
local gears     = require('gears')
local theme     = require('theme')

local mod        = require('config.globals').keys.mod
local systray    = require('widget.systray')
local sensors    = require('widget.sensors')
local text_focus = theme.util.markdown_fg_focus
-- local sound = require('widget.sound')
-- local mpris = require('widget.mpris')

local function panel_gap(is_floating) 
  return is_floating and theme.panel_gap*2 or 0 
end

local function panel_shape(is_rounded)
  return is_rounded and function(cr, w, h)
    gears.shape.rounded_rect(cr, w, h, theme.panel_radius)
  end or gears.shape.rectangle
end

local _M = {}

function _M.new(args)
  local screen    = assert(args.screen)
  local floating  = args.floating or false
  local rounded   = args.rounded or false

  local geom  = screen.geometry
  local gap   = panel_gap(floating)

  -- Create wibox
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
  widget.toggle_floating = function(self)
    self:set_floating(not self.enable_floating)
    self.enable_floating = not self.enable_floating
    self:set_floating(self.enable_floating)
  end
  widget.set_floating = function(self, flag)
    if (not self.enable_floating) then
      return
    end

    if (flag == self.floating) then
      return
    end

    local lgeom = self.screen.geometry
    local lgap = panel_gap(flag)

    self.x     = lgeom.x + lgap
    self.y     = lgeom.y + lgap
    self.width = lgeom.width - 2*lgap

    self:struts {
      top     = theme.panel_size+2*theme.panel_border_w+lgap,
      bottom  = 0,
      left    = 0,
      right   = 0
    }

    self.floating = flag
    self.shape = panel_shape(self.enable_rounding and self.floating)
  end
  widget.make_tray_current = function(self)
    systray.update_screen(self.screen)
  end

  -- Setup wibox contents
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
            (function()
              local layoutbox = awful.widget.layoutbox(screen)
              layoutbox:buttons(gears.table.join(
                awful.button({ }, 1, function() awful.layout.inc( 1) end),
                awful.button({ }, 3, function() awful.layout.inc(-1) end),
                awful.button({ }, 4, function() awful.layout.inc( 1) end),
                awful.button({ }, 5, function() awful.layout.inc(-1) end)
              ))
              return layoutbox
            end)(),
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
        awful.widget.taglist {
          screen  = screen,
          filter  = awful.widget.taglist.filter.all,
          buttons = gears.table.join(
            awful.button({ }, 1, function(t)
              t:view_only()
            end),
            awful.button({ mod }, 1, function(t)
              if (client.focus) then
                client.focus:move_to_tag(t)
              end
            end),
            awful.button({ }, 4, function(t)
              awful.tag.viewnext(t.screen)
            end),
            awful.button({ }, 5, function(t)
              awful.tag.viewprev(t.screen)
            end)
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
        },
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
        awful.widget.tasklist {
          screen  = screen,
          filter  = awful.widget.tasklist.filter.currenttags,
          buttons = gears.table.join(
            awful.button({ }, 1, function(c)
              if (c == client.focus) then
                c.minimized = true
              else
                c:emit_signal("request::activate", "tasklist", { raise = true })
              end
            end),
            awful.button({ }, 3, function()
              awful.menu.client_list({ theme = { width = 250 } })
            end),
            awful.button({ }, 4, function()
              awful.client.focus.byidx(1)
            end),
            awful.button({ }, 5, function()
              awful.client.focus.byidx(-1)
            end)
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
        (function()
          local clock = wibox.widget {
            widget = wibox.container.margin,
            right = 4,
            {
              layout = wibox.layout.fixed.horizontal,
              spacing = 6,
              sensors {
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
          }
          local calendar = awful.widget.calendar_popup.month()
          calendar:attach(clock, "tr")

          return clock
        end)(),
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
          systray {
            screen = screen
          },
        }
      }
    }
  }
  return widget
end

return setmetatable(_M, { __call = function(_, ...) return _M.new(...) end })
