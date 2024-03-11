local app_conf_dir = "/home/nikos/.config/awesome/config/apps"

local apps = {}

apps.list = {
  terminal = "konsole",
  launcher = "rofi -config "..app_conf_dir.."/rofi/config.rasi -show drun"
}

apps.startup = {
  "picom -b --config "..app_conf_dir.."/picom/picom.conf",
  "nm-applet",
  "/usr/lib/kdeconnectd",
  "kdeconnect-indicator",
  "pasystray"
}

return apps
