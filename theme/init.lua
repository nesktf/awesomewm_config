local theme_assets  = require("beautiful.theme_assets")
local dpi           = require("beautiful.xresources").apply_dpi

local theme_path = require('config.globals').path.theme

local function icon_file(str)
  return string.format("%s/icons/%s", theme_path, str)
end

local _conf = {}

-- Colors
_conf.bg_normal     = "#222222"
_conf.bg_focus      = "#535d6c"
_conf.bg_urgent     = "#ff0000"
_conf.bg_minimize   = "#444444"
_conf.fg_normal     = "#888888"
_conf.fg_focus      = "#D4D4D4"
_conf.fg_urgent     = "#FFFFFF"
_conf.fg_minimize   = "#999999"

-- Common things
_conf.useless_gap             = dpi(3)
_conf.wallpaper               = string.format("%s/wallpaper/marisa%d.png", theme_path, 1)
_conf.icon_theme              = "Tela black dark"
_conf.font                    = string.format("Cousine Nerd Font %d", 8)
_conf.notification_font       = _conf.font
_conf.notification_icon_size  = 40
_conf.notification_max_width  = 400
-- _conf.notification_max_height = 50

-- Panel
_conf.systray_icon_spacing  = 8
_conf.panel_gap             = _conf.useless_gap
_conf.panel_radius          = dpi(4)
_conf.panel_size            = dpi(24)
_conf.panel_border_w        = dpi(0)
_conf.panel_color           = "#15181AF0"
_conf.panel_color_alt       = "#25282AF0"
_conf.panel_border          = "#141516F0"
_conf.panel_floating        = false
_conf.panel_rounded         = false
_conf.taglist_squares_sel   = theme_assets.taglist_squares_sel(dpi(4), _conf.fg_normal)
_conf.taglist_squares_unsel = theme_assets.taglist_squares_unsel(dpi(4), _conf.fg_normal)
_conf.menu_height           = dpi(15)
_conf.menu_width            = dpi(100)

-- Client things
_conf.border_width        = dpi(0)
_conf.border_width_tiling = dpi(1)
_conf.border_normal       = _conf.bg_normal
_conf.border_focus        = "#656565"
_conf.border_marked       = "#91231c"
_conf.gap_single_client   = true
_conf.titlebar_bg_focus   = "#272727"
_conf.titlebar_bg_normal  = "#1e1e1e"
_conf.titlebar_top_size   = dpi(22)
_conf.titlebar_bot_size   = 4


-- Titlebar icons
_conf.titlebar_close_button_normal =
  icon_file("titlebar/close_normal.png")
_conf.titlebar_close_button_focus =
  icon_file("titlebar/close_focus.png")
_conf.titlebar_ontop_button_normal_inactive =
  icon_file("titlebar/ontop_normal_inactive.png")
_conf.titlebar_ontop_button_focus_inactive =
  icon_file("titlebar/ontop_focus_inactive.png")
_conf.titlebar_ontop_button_normal_active =
  icon_file("titlebar/ontop_normal_active.png")
_conf.titlebar_ontop_button_focus_active =
  icon_file("titlebar/ontop_focus_active.png")
_conf.titlebar_sticky_button_normal_inactive =
  icon_file("titlebar/sticky_normal_inactive.png")
_conf.titlebar_sticky_button_focus_inactive =
  icon_file("titlebar/sticky_focus_inactive.png")
_conf.titlebar_sticky_button_normal_active =
  icon_file("titlebar/sticky_normal_active.png")
_conf.titlebar_sticky_button_focus_active =
  icon_file("titlebar/sticky_focus_active.png")
_conf.titlebar_floating_button_normal_inactive =
  icon_file("titlebar/floating_normal_inactive.png")
_conf.titlebar_floating_button_focus_inactive =
  icon_file("titlebar/floating_focus_inactive.png")
_conf.titlebar_floating_button_normal_active =
  icon_file("titlebar/floating_normal_active.png")
_conf.titlebar_floating_button_focus_active =
  icon_file("titlebar/floating_focus_active.png")
_conf.titlebar_minimize_button_normal =
  icon_file("titlebar/minimize_normal.png")
_conf.titlebar_minimize_button_focus =
  icon_file("titlebar/minimize_focus.png")
_conf.titlebar_maximized_button_normal_inactive =
  icon_file("titlebar/maximize_normal_inactive.png")
_conf.titlebar_maximized_button_focus_inactive =
  icon_file("titlebar/maximize_focus_inactive.png")
_conf.titlebar_maximized_button_normal_active =
  icon_file("titlebar/maximize_normal_active.png")
_conf.titlebar_maximized_button_focus_active =
  icon_file("titlebar/maximize_focus_active.png")

-- Layout icons
_conf.layout_fairh =
  icon_file("layout-fairh.png")
_conf.layout_fairv =
  icon_file("layout-fairv.png")
_conf.layout_floating =
  icon_file("layout-floating.png")
_conf.layout_magnifier =
  icon_file("layout-magnifier.png")
_conf.layout_max =
  icon_file("layout-max.png")
_conf.layout_tile =
  icon_file("layout-tile.png")
_conf.layout_tilebottom =
  icon_file("layout-tilebottom.png")
_conf.layout_tileleft =
  icon_file("layout-tileleft.png")
_conf.layout_tiletop =
  icon_file("layout-tiletop.png")
_conf.layout_spiral =
  icon_file("layout-spiral.png")

-- Panel icons
_conf.icon_panel_cpu =
  icon_file("panel-cpu.png")
_conf.icon_panel_ram =
  icon_file("panel-ram.png")
_conf.icon_panel_swap =
  icon_file("panel-ram.png")
_conf.icon_panel_temp =
  icon_file("panel-temp.png")
_conf.icon_panel_clock =
  icon_file("panel-clock.png")
_conf.icon_panel_battery =
  icon_file("panel-battery.png")
_conf.icon_panel_tray_open =
  icon_file("panel-tray-open.png")
_conf.icon_panel_tray_close =
  icon_file("panel-tray-close.png")
_conf.awesome_icon =
  theme_assets.awesome_icon(_conf.menu_height, _conf.bg_focus, _conf.fg_focus)

-- Misc icons
_conf.volume_high =
  icon_file("audio-volume-high.png")
_conf.volume_medium =
  icon_file("audio-volume-medium.png")
_conf.volume_low =
  icon_file("audio-volume-low.png")
_conf.volume_mute =
  icon_file("audio-volume-muted.png")
_conf.icon_arrow_left =
  icon_file("arrow_left.png")
_conf.icon_application_menu =
  icon_file("application_menu.png")

return setmetatable({
  get = function()
    return _conf
  end,
  util = {
    markdown_fg_focus = function(str)
      return string.format([[<span foreground='%s'>%s</span>]], _conf.fg_focus, str)
    end,
    icon_file = icon_file,
  }
},{ __index = _conf })
