#!/bin/bash
# ~/.config/scripts/start-up.sh

$HOME/.config/scripts/displays.sh

# Re-launch pywal, this time allowing it to set the background, and execute wal-set afterwards
wal -R -o $HOME/.config/scripts/wal-set.sh

#exec --no-startup-id "wal -i $HOME/pics/rocket_from_forest.jpg"
redshift -O 3400
