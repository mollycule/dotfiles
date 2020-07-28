#!/bin/bash
# ~/.config/scripts/rofi-network.sh
# Rofi wrapper around netctl

profiles="$(find /etc/netctl -maxdepth 1 -type f | cut -d '/' -f 4 | sort | paste -sd '|')"
prompt="Switch Network Profile :"
choice=$(echo "CANCEL|DISABLE|$profiles" | rofi -sep '|' -dmenu -i -only-match -p "$prompt")

if [ $choice == "CANCEL" ]; then
    exit 0
elif [ $choice == "DISABLE" ]; then
    if ! pgrep openvpn; then
        continue
    else
        if ! sudo kill $(pgrep openvpn); then
            notify-send -u critical "NET" "Unable to stop openvpn." &
            exit 1
        fi
    fi
    if ! sudo netctl stop-all; then
        notify-send -u critical "NET" "Unable to stop all network profiles." &
        exit 1
    else
        notify-send -u low "NET" "Successfully stopped all network profiles." &
        exit 0
    fi
else
    notify-send -u low "NET" "Starting network profile..." &
    sudo netctl stop-all
    if ! sudo netctl start $choice; then
        notify-send -u critical "NET" "Unable to start network profile." &
        exit 1
    else
        if echo $choice | grep -q "vpn"; then
            sudo /usr/bin/openvpn /etc/openvpn/client/client.conf &
            sleep 3
            if ! ps -u root | grep -q "openvpn"; then
                notify-send -u critical "NET" "Unable to start vpn profile." &
                exit 1
            else
                notify-send -u low "NET" "Successfully started vpn profile." &
                exit 0
            fi
        else
            notify-send -u low "NET" "Successfully started network profile." &
            exit 0
        fi
    fi
fi
