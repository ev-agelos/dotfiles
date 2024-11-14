#!/bin/bash

# suspend notifications
[[ $(pgrep dunst) > /dev/null ]] && killall -SIGUSR1 dunst

pactl set-sink-mute @DEFAULT_SINK@ true  # mute sound

# Take screenshot of screen, pixelize it and set it as background for locking
if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
    focused_display=$(swaymsg -t get_outputs | jq --compact-output --raw-output '.[] | select( .focused == true ) | .name')
    grim -o $focused_display /tmp/screen.png
else
    scrot /tmp/screen.png
fi

convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png
[[ -f $1 ]] && convert /tmp/screen.png $1 -gravity center -composite -matte /tmp/screen.png

if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
    lock_command='swaylock -i /tmp/screen.png -s fill'
else
    lock_command='i3lock -i /tmp/screen.png'
fi

$lock_command $1

# When on suspend/hibernate just set volume to 0% so when coming back volume is unmuted but 0%
if [[ "$1" == "--no-fork" || "$1" == "" && "$XDG_SESSION_TYPE" == "wayland" ]]; then
    pactl set-sink-volume @DEFAULT_SINK@ 0%
fi

# When unlocked happens: unmute sound. The default sink can be referred as
# @DEFAULT_SINK@ because numbering of sinks is not guaranteed to be persistent
pactl set-sink-mute @DEFAULT_SINK@ false

# resume notifications
[[ $(pgrep dunst) > /dev/null ]] && killall -SIGUSR2 dunst

rm /tmp/screen.png
