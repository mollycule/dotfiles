#!/bin/bash
# ~/.config/scripts/scrot-full.sh
# Script to take a screenshot (fullscreen)

if [ ! -d "$HOME/images/screenshots" ]; then
    mkdir -p "$HOME/images/screenshots"
fi

notify-send -u low "i3" "Taking screenshot..." &
scrot --delay 3 --silent "$HOME/images/screenshots/screenshot.%y-%m-%d.%H-%M.png"
notify-send -u low "i3" "Saved screenshot." &
