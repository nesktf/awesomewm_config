local theme_assets  = require("beautiful.theme_assets")
local xresources    = require("beautiful.xresources")
local dpi           = xresources.apply_dpi

local theme_path = require('config.globals').path.themes .. "/breeze_like"
local icons_path = theme_path .. "/icons"

local _conf = {}

-- Common
_conf.bg_normal     = "#222222"
_conf.bg_focus      = "#535d6c"
_conf.bg_urgent     = "#ff0000"
_conf.bg_minimize   = "#444444"
_conf.fg_normal     = "#CCCCCC"
_conf.fg_focus      = _conf.fg_normal
_conf.fg_urgent     = "#FFFFFF"
_conf.fg_minimize   = "#999999"

-- Gaps
_conf.useless_gap       = dpi(3)
_conf.gap_single_client = true

-- Panel
_conf.panel_gap       = _conf.useless_gap
_conf.panel_radius    = dpi(4)
_conf.panel_size      = dpi(24)
_conf.panel_border_w  = dpi(0)
_conf.panel_color     = "#15181AF0"
_conf.panel_color_alt = "#25282AF0"
_conf.panel_border    = "#141516F0"

-- Systray
_conf.bg_systray           = _conf.panel_color_alt
_conf.systray_icon_spacing = 6
-- __sett.bg_systray    = "#272727"
-- __sett.bg_systray    = "#343434"

-- Borders
_conf.border_width        = dpi(0)
_conf.border_width_tiling = dpi(1)
_conf.border_normal       = _conf.bg_normal
_conf.border_focus        = "#656565"
_conf.border_marked       = "#91231c"
-- __sett.border_normal = "#000000"
-- __sett.border_focus  = "#535d6c"
-- __sett.border_focus = "#415167"

-- Titlebars
_conf.titlebar_bg_focus  = "#272727"
_conf.titlebar_bg_normal = "#1e1e1e"
_conf.titlebar_top_size  = dpi(22)
_conf.titlebar_bot_size  = 4

-- Taglist squares
_conf.taglist_squares_sel   = theme_assets.taglist_squares_sel(dpi(4), _conf.fg_normal)
_conf.taglist_squares_unsel = theme_assets.taglist_squares_unsel(dpi(4), _conf.fg_normal)

-- Notifications
_conf.notification_icon_size = 40
_conf.notification_max_width = 400
-- theme.notification_max_height = 50

-- Menu
_conf.menu_height = dpi(15)
_conf.menu_width  = dpi(100)

-- Awesome icon
_conf.awesome_icon = theme_assets.awesome_icon(_conf.menu_height, _conf.bg_focus, _conf.fg_focus)

-- Titlebar icons
_conf.titlebar_close_button_normal = icons_path.."/titlebar/close_normal.png"
_conf.titlebar_close_button_focus  = icons_path.."/titlebar/close_focus.png"
_conf.titlebar_ontop_button_normal_inactive = icons_path.."/titlebar/ontop_normal_inactive.png"
_conf.titlebar_ontop_button_focus_inactive  = icons_path.."/titlebar/ontop_focus_inactive.png"
_conf.titlebar_ontop_button_normal_active = icons_path.."/titlebar/ontop_normal_active.png"
_conf.titlebar_ontop_button_focus_active  = icons_path.."/titlebar/ontop_focus_active.png"
_conf.titlebar_sticky_button_normal_inactive = icons_path.."/titlebar/sticky_normal_inactive.png"
_conf.titlebar_sticky_button_focus_inactive  = icons_path.."/titlebar/sticky_focus_inactive.png"
_conf.titlebar_sticky_button_normal_active = icons_path.."/titlebar/sticky_normal_active.png"
_conf.titlebar_sticky_button_focus_active  = icons_path.."/titlebar/sticky_focus_active.png"
_conf.titlebar_floating_button_normal_inactive = icons_path.."/titlebar/floating_normal_inactive.png"
_conf.titlebar_floating_button_focus_inactive  = icons_path.."/titlebar/floating_focus_inactive.png"
_conf.titlebar_floating_button_normal_active = icons_path.."/titlebar/floating_normal_active.png"
_conf.titlebar_floating_button_focus_active  = icons_path.."/titlebar/floating_focus_active.png"
_conf.titlebar_minimize_button_normal = icons_path.."/titlebar/minimize_normal.png"
_conf.titlebar_minimize_button_focus  = icons_path.."/titlebar/minimize_focus.png"
_conf.titlebar_maximized_button_normal_inactive = icons_path.."/titlebar/maximize_normal_inactive.png"
_conf.titlebar_maximized_button_focus_inactive  = icons_path.."/titlebar/maximize_focus_inactive.png"
_conf.titlebar_maximized_button_normal_active = icons_path.."/titlebar/maximize_normal_active.png"
_conf.titlebar_maximized_button_focus_active  = icons_path.."/titlebar/maximize_focus_active.png"

-- Layout icons
_conf.layout_fairh = icons_path.."/layouts/fairhw.png"
_conf.layout_fairv = icons_path.."/layouts/fairvw.png"
_conf.layout_floating  = icons_path.."/layouts/floatingw.png"
_conf.layout_magnifier = icons_path.."/layouts/magnifierw.png"
_conf.layout_max = icons_path.."/layouts/maxw.png"
_conf.layout_fullscreen = icons_path.."/layouts/fullscreenw.png"
_conf.layout_tilebottom = icons_path.."/layouts/tilebottomw.png"
_conf.layout_tileleft   = icons_path.."/layouts/tileleftw.png"
_conf.layout_tile = icons_path.."/layouts/tilew.png"
_conf.layout_tiletop = icons_path.."/layouts/tiletopw.png"
_conf.layout_spiral  = icons_path.."/layouts/spiralw.png"
_conf.layout_dwindle = icons_path.."/layouts/dwindlew.png"
_conf.layout_cornernw = icons_path.."/layouts/cornernww.png"
_conf.layout_cornerne = icons_path.."/layouts/cornernew.png"
_conf.layout_cornersw = icons_path.."/layouts/cornersww.png"
_conf.layout_cornerse = icons_path.."/layouts/cornersew.png"

-- Misc icons
_conf.volume_high = icons_path.."/audio-volume-high.png"
_conf.volume_medium = icons_path.."/audio-volume-medium.png"
_conf.volume_low = icons_path.."/audio-volume-low.png"
_conf.volume_mute = icons_path.."/audio-volume-muted.png"
_conf.icon_arrow_left = icons_path.."/arrow_left.png"
_conf.icon_application_menu = icons_path.."/application_menu.png"
-- __sett.tasklist_bg_image_normal = widgets_path.."/tasklist/normal.png"
-- __sett.tasklist_bg_image_focus = widgets_path.."/tasklist/focus.png"
-- __sett.tasklist_bg_image_urgent = widgets_path.."/tasklist/urgent.png"
-- __sett.widget_display_c = widgets_path.."/display/widget_display_c.png"
-- __sett.widget_display_l = widgets_path.."/display/widget_display_l.png"
-- __sett.widget_display_r = widgets_path.."/display/widget_display_r.png"
-- __sett.widget_display = widgets_path.."/display/widget_display.png"


local _M = {}

function _M.settings_with(args)
  local pape = args.wallpaper and args.wallpaper or "marisa0"
  local icon_theme = args.icon_theme and args.icon_theme or "Tela black dark"
  local font = args.font and args.font or "Cousine Nerd Font 8"

  _conf.wallpaper = theme_path.."/wallpaper/"..pape..".png"
  _conf.icon_theme = icon_theme
  _conf.font = font
  _conf.notification_font = font

  return _conf
end

return _M
