#!/bin/bash
# ~/.config/scripts/displays
# A script to appropriately configure xrandr at boot

display_count=$(xrandr | grep ' connected' | wc -l)

work_docked='xrandr --output VIRTUAL1 --off --output DisplayPort-1-2 --mode 1920x1080 --pos 3520x0 --rotate normal --output eDP1 --primary --mode 1600x900 --pos 1920x180 --rotate normal --output DP1 --off --output DisplayPort-1-3 --off --output HDMI2 --off --output HDMI1 --mode 1920x1080 --pos 0x0 --rotate normal --output DP2 --off'

undocked='xrandr --output VIRTUAL1 --off --output DisplayPort-1-2 --off --output eDP1 --primary --mode 1600x900 --pos 1920x180 --rotate normal --output DP1 --off --output DisplayPort-1-3 --off --output HDMI2 --off --output HDMI1 --off --output DP2 --off'

one_monitor_left='xrandr --output VIRTUAL1 --off --output DisplayPort-1-2 --off --output eDP1 --primary --mode 1600x900 --pos 1920x180 --rotate normal --output DP1 --off --output DisplayPort-1-3 --off --output HDMI2 --off --output HDMI1 --mode 1920x1080 --pos 0x0 --rotate normal --output DP2 --off'

if [ $display_count -eq 3 ]; then
    $work_docked
elif [ $display_count -eq 2 ]; then
    $one_monitor_left
else
    $undocked
fi
