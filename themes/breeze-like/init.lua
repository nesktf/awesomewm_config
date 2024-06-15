local theme_assets  = require("beautiful.theme_assets")
local xresources    = require("beautiful.xresources")
local dpi           = xresources.apply_dpi

local theme_path = require('main.globals').path.themes .. "/breeze-like"
local icons_path = theme_path .. "/icons"

local _M = {}

_M.font          = "sans 8"

_M.bg_normal     = "#222222"
_M.bg_focus      = "#535d6c"
_M.bg_urgent     = "#ff0000"
_M.bg_minimize   = "#444444"
_M.bg_systray    = _M.bg_normal

_M.fg_normal     = "#aaaaaa"
_M.fg_focus      = "#ffffff"
_M.fg_urgent     = "#ffffff"
_M.fg_minimize   = "#ffffff"

_M.useless_gap   = dpi(5)
_M.panel_gap     = _M.useless_gap
_M.panel_radius  = dpi(4)
_M.panel_size    = dpi(26)
_M.gap_single_client = true
_M.border_width  = dpi(0)
_M.border_normal = "#000000"
_M.border_focus  = "#535d6c"
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
-- theme.titlebar_bg_normal = "#1e1e1e"
_M.titlebar_bg_normal = "#303030"
  --   -- bg_normal = "#303030"
_M.titlebar_top_size = 22
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
_M.notification_fon = "Cousine Nerd Font"
_M.notification_icon_size = 40
-- theme.notification_max_height = 50
_M.notification_max_width = 400

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
_M.menu_submenu_icon = theme_path.."/submenu.png"
_M.menu_height = dpi(15)
_M.menu_width  = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
_M.titlebar_close_button_normal = icons_path.."/titlebar/close_normal.png"
_M.titlebar_close_button_focus  = icons_path.."/titlebar/close_focus.png"

_M.titlebar_minimize_button_normal = icons_path.."/titlebar/go-down.png"
_M.titlebar_minimize_button_focus  = icons_path.."/titlebar/go-down.png"

_M.titlebar_ontop_button_normal_inactive = icons_path.."/titlebar/go-up-skip.png"
_M.titlebar_ontop_button_focus_inactive  = icons_path.."/titlebar/go-up-skip.png"
_M.titlebar_ontop_button_normal_active = icons_path.."/titlebar/go-up-skip.png"
_M.titlebar_ontop_button_focus_active  = icons_path.."/titlebar/go-up-skip.png"

_M.titlebar_sticky_button_normal_inactive = icons_path.."/titlebar/window-pin.png"
_M.titlebar_sticky_button_focus_inactive  = icons_path.."/titlebar/window-pin.png"
_M.titlebar_sticky_button_normal_active = icons_path.."/titlebar/window-pin.png"
_M.titlebar_sticky_button_focus_active  = icons_path.."/titlebar/window-pin.png"

_M.titlebar_floating_button_normal_inactive = icons_path.."/titlebar/floating_normal_inactive.png"
_M.titlebar_floating_button_focus_inactive  = icons_path.."/titlebar/floating_focus_inactive.png"
_M.titlebar_floating_button_normal_active = icons_path.."/titlebar/floating_normal_active.png"
_M.titlebar_floating_button_focus_active  = icons_path.."/titlebar/floating_focus_active.png"

_M.titlebar_maximized_button_normal_inactive = icons_path.."/titlebar/go-up.png"
_M.titlebar_maximized_button_focus_inactive  = icons_path.."/titlebar/go-up.png"
_M.titlebar_maximized_button_normal_active = icons_path.."/titlebar/window-restore.png"
_M.titlebar_maximized_button_focus_active  = icons_path.."/titlebar/window-restore.png"

_M.wallpaper = theme_path.."/wallpaper/marisa.png"

-- You can use your own layout icons like this:
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

-- Generate Awesome icon:
_M.awesome_icon = theme_assets.awesome_icon(
    _M.menu_height, _M.bg_focus, _M.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/titlebar/hicolor will be used.
_M.icon_theme = nil


_M.volume_high = icons_path.."/audio-volume-high.png"
_M.volume_medium = icons_path.."/audio-volume-medium.png"
_M.volume_low = icons_path.."/audio-volume-low.png"
_M.volume_mute = icons_path.."/audio-volume-muted.png"

return {theme = _M}

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
