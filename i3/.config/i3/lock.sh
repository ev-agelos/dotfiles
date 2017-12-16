#!/bin/bash

killall -SIGUSR1 dunst  # suspend notifications
pactl set-sink-mute @DEFAULT_SINK@ true  # mute sound

# Take screenshot of screen, pixelize it and set it as background for locking
scrot /tmp/screen.png
convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png
[[ -f $1 ]] && convert /tmp/screen.png $1 -gravity center -composite -matte /tmp/screen.png

# support i3lock's --no-fork in case of suspend/hibernation
if [ "$1" == "--nofork" ]; then
    i3lock -i /tmp/screen.png $1
else
    i3lock -i /tmp/screen.png
    # When on suspend/hibernate just set volume to 0% so when coming back
    # volume is unmuted but 0%
    pactl set-sink-volume @DEFAULT_SINK@ 0%
fi

# When unlocked happens: unmute sound. The default sink can be referred as
# @DEFAULT_SINK@ because numbering of sinks is not guaranteed to be persistent
pactl set-sink-mute @DEFAULT_SINK@ false

killall -SIGUSR2 dunst  # resume notifications
rm /tmp/screen.png
