#!/bin/bash
# ~/.config/scripts/displays.sh
# A script to appropriately configure xrandr

display_count=$(xrandr | grep ' connected' | wc -l)

one_monitor="$HOME/.screenlayout/monitor_4k_DP.sh"

undocked="$HOME/.screenlayout/laptop_1080p.sh"

if [ $display_count -eq 2 ]; then
    $one_monitor
else
    $undocked
fi
