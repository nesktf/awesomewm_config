#!/bin/bash

vol_fun() {
  x=${1}
  printf $(qalc -t "(0.0000266933*${x}*${x}*${x})-(0.00307*${x}*${x})+(0.746767*${x})")
}

in=${1}
char=${in:0:1}
curr_vol=$(amixer sget Master | awk -F"[][%]" '/Left:/ { print $2 }')

if [[ ${char} == "+" ]]; then
  x=$(echo ${in} | cut -d'+' -f2)
  left_vol=$((curr_vol+${x}))
  right_vol=$(vol_fun ${left_vol})
  echo amixer sset Master ${left_vol}%+,${right_vol}%+
elif [[ ${char} == "-" ]]; then
  x=$(echo ${in} | cut -d'-' -f2)
  left_vol=$((curr_vol-${x}))
  right_vol=$(vol_fun ${left_vol})
  echo amixer sset Master ${left_vol}%-,${right_vol}%-
else
  left_vol=${in}
  right_vol=$(vol_fun ${left_vol})
  echo amixer sset Master ${left_vol}%,${right_vol}%
fi

