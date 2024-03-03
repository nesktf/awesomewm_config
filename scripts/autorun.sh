#!/bin/sh

run() {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}

setxkbmap es
run picom --backend glx --vsync
#run nm-applet
