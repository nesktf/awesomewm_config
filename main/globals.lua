local home_dir    = os.getenv("HOME")
local awesome_dir = home_dir.. "/.config/awesome"

local _M = {}

_M.keys = {
  mod = "Mod4",
  alt = "Mod1",
}

_M.path = {
  awesome = awesome_dir,
  themes  = awesome_dir .. "/themes",
  config  = awesome_dir .. "/config",
  home    = home_dir,
}

_M.cmd = {
  rofi = "rofi -config ".._M.path.config.."/rofi/config.rasi",
  picom = "picom -b --config ".._M.path.config.."/picom/picom.conf" 
}

_M.app = {
  shell = "bash",
  terminal = "konsole",
  file_manager = "dolphin",
  browser = "librewolf",
  browser_w = "librewolf --profile "..home_dir.."/.librewolf/80zhfr50.work/",
  yt_viewer = "freetube",
  launcher = _M.cmd.rofi .. " -show drun",
  game_launcher = _M.cmd.rofi .. " -show lutris",
  dev_launcher = _M.cmd.rofi .. " -show dev"
}

_M.autostart = {
  on_startup = {
    _M.cmd.picom,
    "nm-applet",
    "kdeconnect-indicator",
    "pasystray",
    "copyq",
    "polkit-dumb-agent"
  },
  on_reload = {
    'setxkbmap es',
    'xinput set-prop "USB OPTICAL MOUSE " "libinput Accel Profile Enabled" 0 1'
  }
}

return _M
