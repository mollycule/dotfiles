#!/bin/bash
# ~/.config/scripts/start-roll20.sh
# Script to automate DMing in Roll20


i3-msg 'workspace 1; exec /usr/bin/chromium "https://roll20.net/welcome"' # Use Chromium until Firefox fixes rendering issue
# TODO open saved session of campaign org docs
i3-msg 'workspace 1; exec /usr/bin/emacs'
i3-msg 'workspace 2; exec /usr/bin/firefox "file://$HOME/personal/dnd/player-handbook.pdf"'
i3-msg 'workspace 2; exec /usr/bin/firefox "file://$HOME/personal/dnd/sword-coast-guide.pdf"'
i3-msg 'workspace 2; exec /usr/bin/slack'

