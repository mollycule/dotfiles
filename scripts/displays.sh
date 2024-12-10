#!/bin/bash
# ~/.config/scripts/displays.sh
# A script to appropriately configure xrandr

display_count=$(xrandr | grep -c ' connected')

one_monitor="$HOME/.screenlayout/monitor_4k_DP.sh"
two_monitor="$HOME/.screenlayout/work_laptop.sh"
undocked="$HOME/.screenlayout/laptop_1080p.sh"

if [ "$display_count" -eq 2 ]; then
  $one_monitor
elif [ "$display_count" -eq 3 ]; then
 $two_monitor
else
  $undocked
fi
