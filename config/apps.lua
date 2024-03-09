local apps = {}

apps.list = {
  terminal = "alacritty"
}

apps.startup = {
  "picom --backend glx --vsync",
  "nm-applet",
  "/usr/lib/kdeconnectd",
  "kdeconnect-indicator",
  "pasystray"
}

return apps
