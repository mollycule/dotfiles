#!/bin/bash
# ~/.config/scripts/rofi-display.sh
# Rofi wrapper around xrandr screenlayouts

layouts="$(find -L $HOME/.screenlayout -maxdepth 1 -executable -type f | cut -d '/' -f 5 | sort | paste -sd '|')"
prompt="Switch X RandR Layout :"
choice=$(echo "CANCEL|$layouts" | rofi -sep '|' -dmenu -i -only-match -p "$prompt")

if [ $choice == "CANCEL" ]; then
  exit 0
else
  notify-send -u low "DIS" "Starting xrandr layout..." &
  if ! $HOME/.screenlayout/$choice; then
    notify-send -u normal "DIS" "Unable to switch xrandr layouts." &
    exit 1
  fi
fi
