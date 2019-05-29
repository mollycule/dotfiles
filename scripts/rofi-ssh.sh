#!/bin/bash
# ~/.config/scripts/rofi-ssh.sh
# Wrapper for rofi's ssh mode

rofi -show ssh -ssh-command 'urxvtc +sb -title "SSH : {host}" -e /home/jhaney/.config/scripts/ssh-wrapper.sh {host}'
