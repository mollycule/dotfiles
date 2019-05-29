#!/bin/bash
# ~/.config/scripts/scrot-select.sh
# Script to take a screenshot (selection)

if [ ! -d "$HOME/pics/screenshots" ]; then
    mkdir -p "$HOME/pics/screenshots"
fi

notify-send -u low "i3" "Select an area to capture screenshot..." -t 2000 &
scrot --select --silent "$HOME/pics/screenshots/screenshot.%y-%m-%d.%H-%M.png"
notify-send -u low "i3" "Saved screenshot." &
