local theme_assets  = require("beautiful.theme_assets")
local xresources    = require("beautiful.xresources")
local dpi           = xresources.apply_dpi

local theme_path = require('config.globals').path.themes .. "/breeze-like"
local icons_path = theme_path .. "/icons"
-- local widgets_path = theme_path .. "/widgets"

local _M = {}

_M.font          = "Cousine Nerd Font 8"

_M.bg_normal     = "#222222"
_M.bg_focus      = "#535d6c"
_M.bg_urgent     = "#ff0000"
_M.bg_minimize   = "#444444"
-- _M.bg_systray    = "#272727"
-- _M.bg_systray    = "#343434"

_M.fg_normal     = "#CCCCCC"
_M.fg_focus      = _M.fg_normal
_M.fg_urgent     = "#FFFFFF"
_M.fg_minimize   = "#999999"

_M.useless_gap   = dpi(3)
_M.panel_gap     = _M.useless_gap
_M.panel_radius  = dpi(4)
_M.panel_size    = dpi(24)
_M.gap_single_client = true
-- _M.panel = widgets_path.."/panel.png"
_M.panel_color   = "#15181AF0"
_M.panel_color_alt = "#25282AF0"
_M.panel_border  = "#141516F0"
_M.panel_border_w = dpi(0)
_M.bg_systray    = _M.panel_color_alt
_M.systray_icon_spacing = 6

_M.border_width  = dpi(0)
_M.border_width_tiling = dpi(1)
_M.border_normal = _M.bg_normal
-- _M.border_normal = "#000000"
-- _M.border_focus  = "#535d6c"
-- _M.border_focus = "#415167"
_M.border_focus = "#656565"
_M.border_marked = "#91231c"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"
_M.titlebar_bg_focus = "#272727"
-- _M.titlebar_bg_focus = _M.bg_systray
_M.titlebar_bg_normal = "#1e1e1e"
-- _M.titlebar_bgimage_normal = _M.panel
-- _M.titlebar_bgimage_focus = _M.panel
-- _M.titlebar_bg_normal = "#303030"
  --   -- bg_normal = "#303030"
_M.titlebar_top_size = dpi(22)
_M.titlebar_bot_size = 4

-- Generate taglist squares:
local taglist_square_size = dpi(4)
_M.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, _M.fg_normal
)
_M.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, _M.fg_normal
)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]
_M.notification_font = "Cousine Nerd Font 8"
_M.notification_icon_size = 40
-- theme.notification_max_height = 50
_M.notification_max_width = 400

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
-- _M.menu_submenu_icon = theme_path.."/submenu.png"
_M.menu_height = dpi(15)
_M.menu_width  = dpi(100)


-- Titlebar icons
_M.titlebar_close_button_normal = icons_path.."/titlebar/close_normal.png"
_M.titlebar_close_button_focus  = icons_path.."/titlebar/close_focus.png"
_M.titlebar_ontop_button_normal_inactive = icons_path.."/titlebar/ontop_normal_inactive.png"
_M.titlebar_ontop_button_focus_inactive  = icons_path.."/titlebar/ontop_focus_inactive.png"
_M.titlebar_ontop_button_normal_active = icons_path.."/titlebar/ontop_normal_active.png"
_M.titlebar_ontop_button_focus_active  = icons_path.."/titlebar/ontop_focus_active.png"
_M.titlebar_sticky_button_normal_inactive = icons_path.."/titlebar/sticky_normal_inactive.png"
_M.titlebar_sticky_button_focus_inactive  = icons_path.."/titlebar/sticky_focus_inactive.png"
_M.titlebar_sticky_button_normal_active = icons_path.."/titlebar/sticky_normal_active.png"
_M.titlebar_sticky_button_focus_active  = icons_path.."/titlebar/sticky_focus_active.png"
_M.titlebar_floating_button_normal_inactive = icons_path.."/titlebar/floating_normal_inactive.png"
_M.titlebar_floating_button_focus_inactive  = icons_path.."/titlebar/floating_focus_inactive.png"
_M.titlebar_floating_button_normal_active = icons_path.."/titlebar/floating_normal_active.png"
_M.titlebar_floating_button_focus_active  = icons_path.."/titlebar/floating_focus_active.png"
_M.titlebar_minimize_button_normal = icons_path.."/titlebar/minimize_normal.png"
_M.titlebar_minimize_button_focus  = icons_path.."/titlebar/minimize_focus.png"
_M.titlebar_maximized_button_normal_inactive = icons_path.."/titlebar/maximize_normal_inactive.png"
_M.titlebar_maximized_button_focus_inactive  = icons_path.."/titlebar/maximize_focus_inactive.png"
_M.titlebar_maximized_button_normal_active = icons_path.."/titlebar/maximize_normal_active.png"
_M.titlebar_maximized_button_focus_active  = icons_path.."/titlebar/maximize_focus_active.png"

-- Layout icons
_M.layout_fairh = icons_path.."/layouts/fairhw.png"
_M.layout_fairv = icons_path.."/layouts/fairvw.png"
_M.layout_floating  = icons_path.."/layouts/floatingw.png"
_M.layout_magnifier = icons_path.."/layouts/magnifierw.png"
_M.layout_max = icons_path.."/layouts/maxw.png"
_M.layout_fullscreen = icons_path.."/layouts/fullscreenw.png"
_M.layout_tilebottom = icons_path.."/layouts/tilebottomw.png"
_M.layout_tileleft   = icons_path.."/layouts/tileleftw.png"
_M.layout_tile = icons_path.."/layouts/tilew.png"
_M.layout_tiletop = icons_path.."/layouts/tiletopw.png"
_M.layout_spiral  = icons_path.."/layouts/spiralw.png"
_M.layout_dwindle = icons_path.."/layouts/dwindlew.png"
_M.layout_cornernw = icons_path.."/layouts/cornernww.png"
_M.layout_cornerne = icons_path.."/layouts/cornernew.png"
_M.layout_cornersw = icons_path.."/layouts/cornersww.png"
_M.layout_cornerse = icons_path.."/layouts/cornersew.png"

-- Misc icons
_M.volume_high = icons_path.."/audio-volume-high.png"
_M.volume_medium = icons_path.."/audio-volume-medium.png"
_M.volume_low = icons_path.."/audio-volume-low.png"
_M.volume_mute = icons_path.."/audio-volume-muted.png"
_M.icon_arrow_left = icons_path.."/arrow_left.png"
_M.icon_application_menu = icons_path.."/application_menu.png"

-- _M.tasklist_bg_image_normal = widgets_path.."/tasklist/normal.png"
-- _M.tasklist_bg_image_focus = widgets_path.."/tasklist/focus.png"
-- _M.tasklist_bg_image_urgent = widgets_path.."/tasklist/urgent.png"

-- _M.widget_display_c = widgets_path.."/display/widget_display_c.png"
-- _M.widget_display_l = widgets_path.."/display/widget_display_l.png"
-- _M.widget_display_r = widgets_path.."/display/widget_display_r.png"
-- _M.widget_display = widgets_path.."/display/widget_display.png"


-- Pape
_M.wallpaper = theme_path.."/wallpaper/marisa0.png"
_M.icon_theme = "Tela black dark"

-- Generate Awesome icon:
_M.awesome_icon = theme_assets.awesome_icon(
    _M.menu_height, _M.bg_focus, _M.fg_focus
)

return {theme = _M}

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
