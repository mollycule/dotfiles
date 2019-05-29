#!/bin/bash
# ~/.config/scripts/scrot-full
# Script to take a screenshot (fullscreen)

#notify-send -u low "i3" "Taking screenshot..."
scrot --delay 3 --silent "$HOME/pics/screenshots/screenshot.%y-%m-%d.%H-%M.png"
#notify-send -u low "i3" "Saved screenshot..."