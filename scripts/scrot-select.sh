#!/bin/bash
# ~/.config/scripts/scrot-select.sh
# Script to take a screenshot (selection)

if [ ! -d "$HOME/images/screenshots" ]; then
    mkdir -p "$HOME/images/screenshots"
fi

notify-send -u low "i3" "Select an area to capture screenshot..." -t 2000 &
scrot --select --silent "$HOME/images/screenshots/screenshot.%y-%m-%d.%H-%M.png"
notify-send -u low "i3" "Saved screenshot." &
