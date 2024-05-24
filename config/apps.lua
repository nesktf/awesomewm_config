local const     = require("config.const")
local home_dir  = const.path.home_dir

local app_conf_dir = home_dir.."/.config/awesome/config/app_conf"
local rofi_cmd = "rofi -config "..app_conf_dir.."/rofi/config.rasi"

local apps = {}

apps.list = {
  shell = "bash",
  terminal = "konsole",
  launcher = rofi_cmd.." -show drun",
  file_manager = "dolphin",
  browser = "librewolf",
  browser_w = "librewolf --profile "..home_dir.."/.librewolf/80zhfr50.work/",
  game_launcher = rofi_cmd.." -show lutris",
  yt_viewer = "freetube",
  dev_launcher = rofi_cmd.." -show dev"
}

apps.startup_bin = {
  "picom -b --config "..app_conf_dir.."/picom/picom.conf",
  "nm-applet",
  "kdeconnect-indicator",
  "pasystray",
  "copyq",
  "polkit-dumb-agent"
}

apps.startup_shell = {
  'setxkbmap es',
  'xinput set-prop "USB OPTICAL MOUSE " "libinput Accel Profile Enabled" 0 1'
}

return apps
