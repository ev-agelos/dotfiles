#!/bin/bash

# suspend notifications
killall -SIGUSR1 dunst
# mute
amixer set Master mute

# Old way with pixels
scrot /tmp/screen.png
convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png
[[ -f $1 ]] && convert /tmp/screen.png $1 -gravity center -composite -matte /tmp/screen.png

# support i3lock's --no-fork in case of suspend/hibernation
if [ "$1" == "--nofork" ]; then
    i3lock -i /tmp/screen.png $1
else
    i3lock -i /tmp/screen.png
fi

killall -SIGUSR2 dunst  # resume notifications
rm /tmp/screen.png

# unmute sound
# The default sink can be referred as @DEFAULT_SINK@ because numbering of sinks is not guaranteed to be persistent
# pactl set-sink-mute @DEFAULT_SINK@ toggle
