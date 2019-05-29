#!/bin/bash
# ~/.config/scripts/lock.sh
# A script to appropriately configure lock screen with or without multi-monitors

# FUTURE TODO: change screenlock or just remove the if statement for different displays
display_count=$(xrandr | grep ' connected' | wc -l)

multi_setup="i3lock --no-unlock-indicator --ignore-empty-password --colo=000000"
uni_setup="i3lock --no-unlock-indicator --ignore-empty-password --color=000000" 

if [ $display_count -gt 1 ]; then
    $multi_setup
else
    $uni_setup
fi
