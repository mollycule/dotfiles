#!/bin/bash
# ~/.config/scripts/rofi-xdg-firefox-profiles.sh
# Rofi wrapper around setting defaults with xdg

# view files in /usr/share/applications

current="$(xdg-settings get default-web-browser | cut -d '.' -f 1)"
profiles="$(find -L /usr/share/applications/ -name 'firefox*desktop' -type f | cut -d '/' -f 5 | cut -d '.' -f 1 | sort | paste -sd '|')"

prompt="Switch Default Web Browser :"
choice=$(echo "CANCEL|$profiles" | rofi -sep '|' -dmenu -i -p "$prompt")

if [ "$choice" == "CANCEL" ]; then
  notify-send -u low "WEB" "Keeping default web browser: [ $current ]" &
  exit 0
else
  if ! [ -f /usr/share/applications/"$choice".desktop ]; then
    notify-send -u critical "WEB" "Unable to configure default web browser." &
    exit 1
  else
    notify-send -u low "WEB" "Default web browser: [ $choice ]" &
    unset BROWSER
    xdg-settings set default-web-browser "$choice".desktop || exit 2
  fi
fi
