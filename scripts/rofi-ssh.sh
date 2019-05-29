#!/bin/bash
# ~/.config/scripts/rofi-ssh
# Wrapper for rofi's ssh mode

rofi -show ssh -ssh-command 'urxvtc +sb -title "SSH : {host}" -e /home/jhaney/.config/scripts/ssh-wrapper {host}'