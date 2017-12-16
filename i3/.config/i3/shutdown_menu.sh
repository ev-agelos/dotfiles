#!/bin/bash

RES=$(echo "lock|logout|restart|suspend|hibernate|shutdown" | rofi -dmenu -i -sep "|" -p 'Power Menu: ' "" -width 16 -lines 6 -eh 1 -hide-scrollbar -padding 20 -font "Awesome 10, Hack 15")
LOCK=$HOME/.config/i3/lock.sh

if [[ $RES = "lock" ]]; then
    $LOCK --nofork
elif [[ $RES = "logout" ]]; then
    i3-msg exit
elif [[ $RES = "restart" ]]; then
    systemctl reboot
elif [[ $RES = "suspend" ]]; then
    $LOCK && systemctl suspend
elif [[ $RES = "hibernate" ]]; then
    $LOCK && systemctl hibernate
elif [[ $RES = "shutdown" ]]; then
    systemctl poweroff
fi
exit 0
