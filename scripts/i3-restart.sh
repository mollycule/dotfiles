#!/bin/bash
# ~/.config/scripts/i3-restart.sh
# Wrapper script for restarting i3 in-place

rofi -e "[!] The window manager will now restart." -width -44
i3-msg reload >/dev/null 2>&1
$HOME/.config/scripts/wal-set.sh # reload dunst, polybar, and wal
notify-send -u low "i3" "Successfully restarted window manager..." &

