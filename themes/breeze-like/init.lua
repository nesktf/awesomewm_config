local theme_assets  = require("beautiful.theme_assets")
local xresources    = require("beautiful.xresources")
local dpi           = xresources.apply_dpi

local theme_path = require('config.globals').path.themes .. "/breeze-like"
local icons_path = theme_path .. "/icons"

local settings = {}

-- Common
settings.bg_normal     = "#222222"
settings.bg_focus      = "#535d6c"
settings.bg_urgent     = "#ff0000"
settings.bg_minimize   = "#444444"
settings.fg_normal     = "#CCCCCC"
settings.fg_focus      = settings.fg_normal
settings.fg_urgent     = "#FFFFFF"
settings.fg_minimize   = "#999999"

-- Gaps
settings.useless_gap       = dpi(3)
settings.gap_single_client = true

-- Panel
settings.panel_gap       = settings.useless_gap
settings.panel_radius    = dpi(4)
settings.panel_size      = dpi(24)
settings.panel_border_w  = dpi(0)
settings.panel_color     = "#15181AF0"
settings.panel_color_alt = "#25282AF0"
settings.panel_border    = "#141516F0"

-- Systray
settings.bg_systray           = settings.panel_color_alt
settings.systray_icon_spacing = 6
-- settings.bg_systray    = "#272727"
-- settings.bg_systray    = "#343434"

-- Borders
settings.border_width        = dpi(0)
settings.border_width_tiling = dpi(1)
settings.border_normal       = settings.bg_normal
settings.border_focus        = "#656565"
settings.border_marked       = "#91231c"
-- settings.border_normal = "#000000"
-- settings.border_focus  = "#535d6c"
-- settings.border_focus = "#415167"

-- Titlebars
settings.titlebar_bg_focus  = "#272727"
settings.titlebar_bg_normal = "#1e1e1e"
settings.titlebar_top_size  = dpi(22)
settings.titlebar_bot_size  = 4

-- Taglist squares
settings.taglist_squares_sel   = theme_assets.taglist_squares_sel(dpi(4), settings.fg_normal)
settings.taglist_squares_unsel = theme_assets.taglist_squares_unsel(dpi(4), settings.fg_normal)

-- Notifications
settings.notification_icon_size = 40
settings.notification_max_width = 400
-- theme.notification_max_height = 50

-- Menu
settings.menu_height = dpi(15)
settings.menu_width  = dpi(100)

-- Awesome icon
settings.awesome_icon = theme_assets.awesome_icon(settings.menu_height, settings.bg_focus, settings.fg_focus)

-- Titlebar icons
settings.titlebar_close_button_normal = icons_path.."/titlebar/close_normal.png"
settings.titlebar_close_button_focus  = icons_path.."/titlebar/close_focus.png"
settings.titlebar_ontop_button_normal_inactive = icons_path.."/titlebar/ontop_normal_inactive.png"
settings.titlebar_ontop_button_focus_inactive  = icons_path.."/titlebar/ontop_focus_inactive.png"
settings.titlebar_ontop_button_normal_active = icons_path.."/titlebar/ontop_normal_active.png"
settings.titlebar_ontop_button_focus_active  = icons_path.."/titlebar/ontop_focus_active.png"
settings.titlebar_sticky_button_normal_inactive = icons_path.."/titlebar/sticky_normal_inactive.png"
settings.titlebar_sticky_button_focus_inactive  = icons_path.."/titlebar/sticky_focus_inactive.png"
settings.titlebar_sticky_button_normal_active = icons_path.."/titlebar/sticky_normal_active.png"
settings.titlebar_sticky_button_focus_active  = icons_path.."/titlebar/sticky_focus_active.png"
settings.titlebar_floating_button_normal_inactive = icons_path.."/titlebar/floating_normal_inactive.png"
settings.titlebar_floating_button_focus_inactive  = icons_path.."/titlebar/floating_focus_inactive.png"
settings.titlebar_floating_button_normal_active = icons_path.."/titlebar/floating_normal_active.png"
settings.titlebar_floating_button_focus_active  = icons_path.."/titlebar/floating_focus_active.png"
settings.titlebar_minimize_button_normal = icons_path.."/titlebar/minimize_normal.png"
settings.titlebar_minimize_button_focus  = icons_path.."/titlebar/minimize_focus.png"
settings.titlebar_maximized_button_normal_inactive = icons_path.."/titlebar/maximize_normal_inactive.png"
settings.titlebar_maximized_button_focus_inactive  = icons_path.."/titlebar/maximize_focus_inactive.png"
settings.titlebar_maximized_button_normal_active = icons_path.."/titlebar/maximize_normal_active.png"
settings.titlebar_maximized_button_focus_active  = icons_path.."/titlebar/maximize_focus_active.png"

-- Layout icons
settings.layout_fairh = icons_path.."/layouts/fairhw.png"
settings.layout_fairv = icons_path.."/layouts/fairvw.png"
settings.layout_floating  = icons_path.."/layouts/floatingw.png"
settings.layout_magnifier = icons_path.."/layouts/magnifierw.png"
settings.layout_max = icons_path.."/layouts/maxw.png"
settings.layout_fullscreen = icons_path.."/layouts/fullscreenw.png"
settings.layout_tilebottom = icons_path.."/layouts/tilebottomw.png"
settings.layout_tileleft   = icons_path.."/layouts/tileleftw.png"
settings.layout_tile = icons_path.."/layouts/tilew.png"
settings.layout_tiletop = icons_path.."/layouts/tiletopw.png"
settings.layout_spiral  = icons_path.."/layouts/spiralw.png"
settings.layout_dwindle = icons_path.."/layouts/dwindlew.png"
settings.layout_cornernw = icons_path.."/layouts/cornernww.png"
settings.layout_cornerne = icons_path.."/layouts/cornernew.png"
settings.layout_cornersw = icons_path.."/layouts/cornersww.png"
settings.layout_cornerse = icons_path.."/layouts/cornersew.png"

-- Misc icons
settings.volume_high = icons_path.."/audio-volume-high.png"
settings.volume_medium = icons_path.."/audio-volume-medium.png"
settings.volume_low = icons_path.."/audio-volume-low.png"
settings.volume_mute = icons_path.."/audio-volume-muted.png"
settings.icon_arrow_left = icons_path.."/arrow_left.png"
settings.icon_application_menu = icons_path.."/application_menu.png"
-- settings.tasklist_bg_image_normal = widgets_path.."/tasklist/normal.png"
-- settings.tasklist_bg_image_focus = widgets_path.."/tasklist/focus.png"
-- settings.tasklist_bg_image_urgent = widgets_path.."/tasklist/urgent.png"
-- settings.widget_display_c = widgets_path.."/display/widget_display_c.png"
-- settings.widget_display_l = widgets_path.."/display/widget_display_l.png"
-- settings.widget_display_r = widgets_path.."/display/widget_display_r.png"
-- settings.widget_display = widgets_path.."/display/widget_display.png"


local _M = {}

function _M.settings_with(args)
  local pape = args.wallpaper and args.wallpaper or "marisa0"
  local icon_theme = args.icon_theme and args.icon_theme or "Tela black dark"
  local font = args.font and args.font or "Cousine Nerd Font 8"

  settings.wallpaper = theme_path.."/wallpaper/"..pape..".png"
  settings.icon_theme = icon_theme
  settings.font = font
  settings.notification_font = font

  return settings
end

return _M
