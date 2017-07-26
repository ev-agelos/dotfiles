#!/bin/bash
scrot /tmp/screen.png
convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png
[[ -f $1 ]] && convert /tmp/screen.png $1 -gravity center -composite -matte /tmp/screen.png
# If spotify is used uncomment the below line to make it pause when lock..
# dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Stop

# suspend notifications
pkill -u "$USER" -USR1 dunst
# mute
amixer set Master mute
# unmute needs calling i3lock -n which makes hibernation to hang

i3lock -i /tmp/screen.png
rm /tmp/screen.png

# resume notifications
pkill -u "$USER" -USR2 dunst
