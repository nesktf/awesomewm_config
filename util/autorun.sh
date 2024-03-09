#!/bin/sh

run() {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}

setxkbmap es
xinput set-prop "USB OPTICAL MOUSE " "libinput Accel Profile Enabled" 0 1 0

run picom --backend glx --vsync
run nm-applet
run /usr/lib/kdeconnectd
run kdeconnect-indicator
run pasystray
