#!/bin/bash
# ~/.config/scripts/headphones.sh

SOUND_CARD=$(aplay -l | awk -F '[ :]+' '/card [0-9].*SteelSeries/ { print $2; exit }')
STREAM="PCM,1"

if ! amixer -c "${SOUND_CARD}" set "${STREAM}" 0dB; then
  notify-send -u critical "VOL" "Unable to set volume." &
  exit 1
else
  notify-send -u low "VOL" "Setting headphone volume to 0dB." &
fi

