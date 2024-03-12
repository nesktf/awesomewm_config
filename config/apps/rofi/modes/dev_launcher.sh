#!/usr/bin/env bash

dev_root="/sdr/Files/Docs/Dev"
editor_cmd="konsole --workdir=%s konsole -e nvim %s"

if [ -z $ROFI_INFO ]; then
  find "$dev_root" -type f -iname '.rofi_scan' -printf "%P\0"|
    while IFS= read -r -d '' file; do
      name="${file%%/.*}"
      source "$dev_root/$file"
      if [[ "$type" == "dev_launcher" ]]; then
        main_file="$name/$main"
        echo -en "$name\0icon\x1flutris\x1finfo\x1f$name;$main\n"
      fi
    done
else
  workdir="$dev_root/$(echo $ROFI_INFO | cut -d';' -f1)"
  main_file=$(echo $ROFI_INFO | cut -d';' -f2)
  cmd=$(printf "$editor_cmd" $workdir $main_file)
  coproc ($cmd >/dev/null 2>&1)
fi
