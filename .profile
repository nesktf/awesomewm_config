#!/bin/sh

## GTK bullshit
export GTK_USE_PORTAL=1
export GTK_THEME=Materia-dark-compact
# MOZ_ENABLE_WAYLAND=0

## Locale
# LC_ALL=en_GB.UTF-8
export LANG=en_US.UTF-8
export LC_TIME=en_GB.UTF-8
export LC_IDENTIFICATION=es_AR.UTF-8
export LC_MEASUREMENT=es_AR.UTF-8
export LC_MONETARY=es_AR.UTF-8
export LC_NAME=es_AR.UTF-8
export LC_NUMERIC=es_AR.UTF-8
export LC_PAPER=es_AR.UTF-8

## Session vars
if [ "$DESKTOP_SESSION" = awesome ]; then
  #export XDG_CURRENT_DESKTOP=KDE
  export QT_STYLE_OVERRIDE=kvantum
  export QT_QPA_PLATFORMTHEME=qt5ct
  export XCURSOR_THEME=breeze_cursors
elif [ "$DESKTOP_SESSION" = plasma ]; then
  export QT_QPA_PLATFORMTHEME=kvantum
  # unset QT_QPA_PLATFORMTHEME
fi
eval $(luarocks path --bin)
