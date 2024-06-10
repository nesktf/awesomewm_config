#!/usr/bin/env bash

db_file="/home/nikos/.local/share/lutris/pga.db"
query="SELECT name,slug FROM games WHERE hidden = 0 ORDER BY name"

if [ -z $ROFI_INFO ]; then
  echo -en "Open Lutris\0icon\x1flutris\x1finfo\x1flutris\n"
  sqlite3 "$db_file" "$query" | while IFS='|' read name slug; do
    echo -en "$name\0icon\x1flutris_$slug\x1finfo\x1f$slug\n"
  done
else
  if [[ $ROFI_INFO == "lutris" ]]; then
    coproc (lutris >/dev/null 2>&1)
  else
    kdialog --passivepopup "Opening $ROFI_INFO..." --title "rofi-lutris" --icon "lutris_$ROFI_INFO" 5 >/dev/null 2>&1
    coproc (lutris "lutris:rungame/$ROFI_INFO" >/dev/null 2>&1)
  fi
  exit 0
fi
