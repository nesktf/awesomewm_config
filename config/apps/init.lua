local home_dir = "/home/nikos"
local app_conf_dir = home_dir.."/.config/awesome/config/apps"

local apps = {}

apps.list = {
  terminal = "konsole",
  launcher = "rofi -config "..app_conf_dir.."/rofi/config.rasi -show drun",
  file_manager = "dolphin",
  browser = "librewolf",
  browser_w = "librewolf --profile "..home_dir.."/.librewolf/80zhfr50.work/",
  game_launcher = "lutris"
}

apps.startup = {
  "picom -b --config "..app_conf_dir.."/picom/picom.conf",
  "nm-applet",
  "/usr/lib/kdeconnectd",
  "kdeconnect-indicator",
  "pasystray"
}

return apps
