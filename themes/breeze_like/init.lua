local theme_assets  = require("beautiful.theme_assets")
local xresources    = require("beautiful.xresources")
local dpi           = xresources.apply_dpi

local theme_path = require('config.globals').path.themes .. "/breeze_like"
local icons_path = theme_path .. "/icons"

local __sett = {}

-- Common
__sett.bg_normal     = "#222222"
__sett.bg_focus      = "#535d6c"
__sett.bg_urgent     = "#ff0000"
__sett.bg_minimize   = "#444444"
__sett.fg_normal     = "#CCCCCC"
__sett.fg_focus      = __sett.fg_normal
__sett.fg_urgent     = "#FFFFFF"
__sett.fg_minimize   = "#999999"

-- Gaps
__sett.useless_gap       = dpi(3)
__sett.gap_single_client = true

-- Panel
__sett.panel_gap       = __sett.useless_gap
__sett.panel_radius    = dpi(4)
__sett.panel_size      = dpi(24)
__sett.panel_border_w  = dpi(0)
__sett.panel_color     = "#15181AF0"
__sett.panel_color_alt = "#25282AF0"
__sett.panel_border    = "#141516F0"

-- Systray
__sett.bg_systray           = __sett.panel_color_alt
__sett.systray_icon_spacing = 6
-- __sett.bg_systray    = "#272727"
-- __sett.bg_systray    = "#343434"

-- Borders
__sett.border_width        = dpi(0)
__sett.border_width_tiling = dpi(1)
__sett.border_normal       = __sett.bg_normal
__sett.border_focus        = "#656565"
__sett.border_marked       = "#91231c"
-- __sett.border_normal = "#000000"
-- __sett.border_focus  = "#535d6c"
-- __sett.border_focus = "#415167"

-- Titlebars
__sett.titlebar_bg_focus  = "#272727"
__sett.titlebar_bg_normal = "#1e1e1e"
__sett.titlebar_top_size  = dpi(22)
__sett.titlebar_bot_size  = 4

-- Taglist squares
__sett.taglist_squares_sel   = theme_assets.taglist_squares_sel(dpi(4), __sett.fg_normal)
__sett.taglist_squares_unsel = theme_assets.taglist_squares_unsel(dpi(4), __sett.fg_normal)

-- Notifications
__sett.notification_icon_size = 40
__sett.notification_max_width = 400
-- theme.notification_max_height = 50

-- Menu
__sett.menu_height = dpi(15)
__sett.menu_width  = dpi(100)

-- Awesome icon
__sett.awesome_icon = theme_assets.awesome_icon(__sett.menu_height, __sett.bg_focus, __sett.fg_focus)

-- Titlebar icons
__sett.titlebar_close_button_normal = icons_path.."/titlebar/close_normal.png"
__sett.titlebar_close_button_focus  = icons_path.."/titlebar/close_focus.png"
__sett.titlebar_ontop_button_normal_inactive = icons_path.."/titlebar/ontop_normal_inactive.png"
__sett.titlebar_ontop_button_focus_inactive  = icons_path.."/titlebar/ontop_focus_inactive.png"
__sett.titlebar_ontop_button_normal_active = icons_path.."/titlebar/ontop_normal_active.png"
__sett.titlebar_ontop_button_focus_active  = icons_path.."/titlebar/ontop_focus_active.png"
__sett.titlebar_sticky_button_normal_inactive = icons_path.."/titlebar/sticky_normal_inactive.png"
__sett.titlebar_sticky_button_focus_inactive  = icons_path.."/titlebar/sticky_focus_inactive.png"
__sett.titlebar_sticky_button_normal_active = icons_path.."/titlebar/sticky_normal_active.png"
__sett.titlebar_sticky_button_focus_active  = icons_path.."/titlebar/sticky_focus_active.png"
__sett.titlebar_floating_button_normal_inactive = icons_path.."/titlebar/floating_normal_inactive.png"
__sett.titlebar_floating_button_focus_inactive  = icons_path.."/titlebar/floating_focus_inactive.png"
__sett.titlebar_floating_button_normal_active = icons_path.."/titlebar/floating_normal_active.png"
__sett.titlebar_floating_button_focus_active  = icons_path.."/titlebar/floating_focus_active.png"
__sett.titlebar_minimize_button_normal = icons_path.."/titlebar/minimize_normal.png"
__sett.titlebar_minimize_button_focus  = icons_path.."/titlebar/minimize_focus.png"
__sett.titlebar_maximized_button_normal_inactive = icons_path.."/titlebar/maximize_normal_inactive.png"
__sett.titlebar_maximized_button_focus_inactive  = icons_path.."/titlebar/maximize_focus_inactive.png"
__sett.titlebar_maximized_button_normal_active = icons_path.."/titlebar/maximize_normal_active.png"
__sett.titlebar_maximized_button_focus_active  = icons_path.."/titlebar/maximize_focus_active.png"

-- Layout icons
__sett.layout_fairh = icons_path.."/layouts/fairhw.png"
__sett.layout_fairv = icons_path.."/layouts/fairvw.png"
__sett.layout_floating  = icons_path.."/layouts/floatingw.png"
__sett.layout_magnifier = icons_path.."/layouts/magnifierw.png"
__sett.layout_max = icons_path.."/layouts/maxw.png"
__sett.layout_fullscreen = icons_path.."/layouts/fullscreenw.png"
__sett.layout_tilebottom = icons_path.."/layouts/tilebottomw.png"
__sett.layout_tileleft   = icons_path.."/layouts/tileleftw.png"
__sett.layout_tile = icons_path.."/layouts/tilew.png"
__sett.layout_tiletop = icons_path.."/layouts/tiletopw.png"
__sett.layout_spiral  = icons_path.."/layouts/spiralw.png"
__sett.layout_dwindle = icons_path.."/layouts/dwindlew.png"
__sett.layout_cornernw = icons_path.."/layouts/cornernww.png"
__sett.layout_cornerne = icons_path.."/layouts/cornernew.png"
__sett.layout_cornersw = icons_path.."/layouts/cornersww.png"
__sett.layout_cornerse = icons_path.."/layouts/cornersew.png"

-- Misc icons
__sett.volume_high = icons_path.."/audio-volume-high.png"
__sett.volume_medium = icons_path.."/audio-volume-medium.png"
__sett.volume_low = icons_path.."/audio-volume-low.png"
__sett.volume_mute = icons_path.."/audio-volume-muted.png"
__sett.icon_arrow_left = icons_path.."/arrow_left.png"
__sett.icon_application_menu = icons_path.."/application_menu.png"
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

  __sett.wallpaper = theme_path.."/wallpaper/"..pape..".png"
  __sett.icon_theme = icon_theme
  __sett.font = font
  __sett.notification_font = font

  return __sett
end

return _M
