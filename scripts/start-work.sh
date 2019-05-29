#!/bin/bash
# ~/.config/scripts/start-work.sh

i3-msg 'workspace 2; exec /usr/bin/chromium --app=https://rocketchat.wolfram.com' && sleep 5s
i3-msg 'workspace 7; exec /usr/bin/thunderbird'
