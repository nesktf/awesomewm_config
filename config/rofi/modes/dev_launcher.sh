#!/usr/bin/env bash

root_link="/sdr/projects"
dev_root="$(readlink ${root_link})/dev"
editor_cmd="alacritty --working-directory=%s -e nvim %s"

if [ -z $ROFI_INFO ]; then
  # find -L "$dev_root" -type f -iname '.rofi_scan' -printf "%P\0"|
  find -L "$dev_root" -mindepth 2 -maxdepth 2 -type d ! -path '*archive*' -printf "%P\0" |
    while IFS= read -r -d '' dir; do
      echo -en "${dir}\0icon\x1flutris\x1finfo\x1f$dir\n"
      # name="${file%%/.*}"
      # source "$dev_root/$file"
      # if [[ "$type" == "dev_launcher" ]]; then
      #   main_file="$name/$main"
      #   echo -en "$name\0icon\x1flutris\x1finfo\x1f$name;$main\n"
      # fi
    done
else
  workdir="${dev_root}/$(echo $ROFI_INFO)"
  # workdir="$dev_root/$(echo $ROFI_INFO | cut -d';' -f1)"
  # main_file=$(echo $ROFI_INFO | cut -d';' -f2)
  cmd=$(printf "$editor_cmd" $workdir $main_file)
  coproc ($cmd >/dev/null 2>&1)
fi
