#!/bin/bash
# ~/.config/scripts/rofi-exit.sh
# A simple wrapper around rofi for exiting the window manager.

options="Cancel|Logout|Restart|Shutdown"
prompt="Mmmmmyyyeeeessss?"

result=$(echo "$options" | rofi -sep "|" -dmenu -i -only-match -l 4 -p "$prompt")

if [ "$result" == "Cancel" ]; then
    exit 0
elif [ "$result" == "Logout" ]; then
    i3-msg exit
elif [ "$result" == "Restart" ]; then
    systemctl reboot
elif [ "$result" == "Shutdown" ]; then
    if pgrep openvpn; then
        sudo pkill openvpn || exit 2
    fi
    systemctl poweroff
else
    echo "Unknown option."
    exit 1
fi

