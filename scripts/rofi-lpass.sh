#!/bin/bash
# ~/.config/scripts/rofi-lpass.sh
# Simple wrapper script for rofi-lpass.py

notify-send -u low "i3" "Fetching password database..." &

output=$($HOME/.config/scripts/rofi-lpass.py)

if [ "$output" = "ERROR" ]; then
    notify-send -u normal "i3" "Encountered runtime error." &
elif [ "$output" = "CANCEL" ]; then
    notify-send -u normal "i3" "Action cancelled [1]." &
elif [ "$output" = "" ]; then
    notify-send -u normal "i3" "Action cancelled [2]." &
elif [ "$output" = "LOGOUT" ]; then
    notify-send -u normal "i3" "Successfully logged-out." &
else
    echo -n "$output" | xclip -sel clip
    notify-send -u normal "i3" "Password copied to clipboard." &
fi
