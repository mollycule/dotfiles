#!/bin/bash
# ~/.config/scripts/docking.sh
# This script is to make transitioning between docked and undocked smoother

# Use xrandr to decide how many displays are available
$HOME/.config/scripts/displays.sh

# Restart polybar to work with the available displays
$HOME/.config/scripts/wal-set.sh

# Make sure the wallpaper is set up correctly
wal -R -o $HOME/.config/scripts/wal-set.sh

