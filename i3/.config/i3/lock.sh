#!/bin/bash

# suspend notifications
pkill -u "$USER" -USR1 dunst
# mute
amixer set Master mute
# unmute needs calling i3lock -n which makes hibernation to hang


# Old way with pixels
#scrot /tmp/screen.png
#convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png
#[[ -f $1 ]] && convert /tmp/screen.png $1 -gravity center -composite -matte /tmp/screen.png
#
#i3lock -i /tmp/screen.png
#rm /tmp/screen.png

# Using i3lock-fancy
i3lock-fancy

# resume notifications
pkill -u "$USER" -USR2 dunst
