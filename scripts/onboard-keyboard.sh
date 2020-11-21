#!/usr/bin/env bash
# A script to launch/kill the onboard keyboard

if pgrep -x /usr/bin/onboard >/dev/null; then
    killall -q /usr/bin/onboard
else
    /usr/bin/onboard --theme Droid &
fi
