local apps = {}

apps.list = {
  terminal = "konsole"
}

apps.startup = {
  "picom -b",
  "nm-applet",
  "/usr/lib/kdeconnectd",
  "kdeconnect-indicator",
  "pasystray"
}

return apps
