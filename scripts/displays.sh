#!/bin/bash
# ~/.config/scripts/displays.sh
# A script to appropriately configure xrandr

display_count=$(xrandr | grep ' connected' | wc -l)

work_docked='xrandr --output VIRTUAL1 --off --output DisplayPort-1-2 --mode 1920x1080 --pos 3520x120 --rotate normal --output eDP1 --primary --mode 1600x900 --pos 0x88 --rotate normal --output DP1 --off --output DisplayPort-1-3 --off --output HDMI2 --off --output HDMI1 --mode 1920x1200 --pos 1600x0 --rotate normal --output DP2 --off'

undocked='xrandr --output VIRTUAL1 --off --output DisplayPort-1-2 --off --output eDP1 --primary --mode 1600x900 --pos 1920x180 --rotate normal --output DP1 --off --output DisplayPort-1-3 --off --output HDMI2 --off --output HDMI1 --off --output DP2 --off'

one_monitor_left='xrandr --output VIRTUAL1 --off --output DisplayPort-1-2 --off --output eDP1 --primary --mode 1600x900 --pos 1280x124 --rotate normal --output DP1 --off --output DisplayPort-1-3 --off --output HDMI2 --off --output HDMI1 --off --output DP2 --mode 1280x1024 --pos 0x0 --rotate normal'

if [ $display_count -eq 3 ]; then
    $work_docked
elif [ $display_count -eq 2 ]; then
    $one_monitor_left
else
    $undocked
fi
