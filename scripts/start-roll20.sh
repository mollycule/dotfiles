#!/bin/bash
# ~/.config/scripts/start-roll20.sh
# Script to automate DMing in Roll20

# TODO get an i3 layout defined so that i don't use sleep statements to align things
# Use Chromium until Firefox fixes rendering issue
i3-msg 'workspace 1; exec /usr/bin/chromium "https://roll20.net/welcome"' && sleep 2s
i3-msg 'workspace 1; exec /usr/bin/discord' && sleep 3s
# TODO open saved session of campaign org docs - saved workspace to file, not sure if it can be defined on cmdline
i3-msg 'workspace 1; exec /usr/bin/emacs' && sleep 2s
i3-msg 'workspace 2; exec /usr/bin/firefox "file://$HOME/personal/dnd/player-handbook.pdf"'
i3-msg 'workspace 2; exec /usr/bin/firefox "file://$HOME/personal/dnd/sword-coast-guide.pdf"'
i3-msg 'workspace 2; exec /usr/bin/firefox "file://$HOME/personal/dnd/dungeon-master-guide.pdf"'
i3-msg 'workspace 2; exec /usr/bin/slack'
i3-msg 'workspace 3; exec /usr/bin/firefox "file://$HOME/personal/dnd/dungeon-master-screen.pdf"'
