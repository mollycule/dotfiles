#!/bin/bash
# ~/.config/scripts/start-up.sh

$HOME/.config/scripts/displays.sh

# Relaunch pywal, dunst, and polybar
wal -R -o $HOME/.config/scripts/wal-set.sh

# Set color temperature of display
redshift -O 3400
