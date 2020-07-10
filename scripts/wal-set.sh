#!/usr/bin/env bash
# ~/.config/scripts/wal-set.sh
# A modified version of Dylan Araps' script (https://github.com/dylanaraps/bin/blob/master/wal-set)

if [ -f "$HOME/.config/x/exports.sh" ]; then
  source "${HOME}/.config/x/exports.sh"
fi

# Import the colors generated by wal
if [ -f "$HOME/.cache/wal/colors.sh" ]; then
  source "${HOME}/.cache/wal/colors.sh"
fi

# Restart and re-theme the notification system
killall -9 dunst

# Substitute environment variables before launching
# (since dunst can't handle environment variables >_>) 
dunst -lb "$color3" -nb "$color0" -cb "$color4" -conf <(envsubst < $HOME/.config/dunst/dunstrc) &

# Restart and re-theme polybar
killall -q polybar >/dev/null 2>&1
$HOME/.config/polybar/launch.sh

# Copy and instantiate Emacs theming
if [ -d $HOME/.emacs.d/themes ]; then
  mkdir -p $HOME/.emacs.d/themes
fi

cp -f $HOME/.cache/wal/colors-emacs.el $HOME/.emacs.d/themes/wal.el

# Reload cached wallpaper
# Especially helpful after display change (such as un/docking)
if [ -f "$HOME/.cache/wal/wal" ]; then
  wal -i "$wallpaper"
fi
