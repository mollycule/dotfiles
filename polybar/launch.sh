#!/usr/bin/env sh
# ~/.config/polybar/launch.sh
# polybar launch script

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

#TODO clean up bars
# Launch polybar for the main display
#polybar bar-primary &

# Launch polybar for the two other monitors, if they are active
AVAILABLE_MONITORS=$(polybar --list-monitors)
if echo $AVAILABLE_MONITORS | grep -q 'eDP-1'; then
	polybar bar-primary &
fi
if echo $AVAILABLE_MONITORS | grep -q -E '(HDMI-1|DP-1-2)'; then
	polybar bar-single-monitor &
fi
if echo $AVAILABLE_MONITORS | grep -q 'DisplayPort-1-2'; then
	polybar bar-right &
fi
