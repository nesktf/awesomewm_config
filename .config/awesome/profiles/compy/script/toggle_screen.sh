#!/usr/bin/env bash

if [[ $(xrandr --listmonitors | wc -l) -eq "3" ]]; then
  xrandr --output DisplayPort-0 --off
  printf "Secondary display disabled"
else
  xrandr --output DisplayPort-0 --mode 1280x1024 --pos 1920x28 --rotate normal
  printf "Secondary display enabled"
fi
