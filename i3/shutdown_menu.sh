#!/bin/bash

RES=$(echo "lock|logout|restart|suspend|shutdown" | rofi -dmenu -i -sep "|" -p 'Power Menu: ' "" -width 16 -eh 1 -hide-scrollbar -padding 20 -font "Awesome 10, Hack 15")
LOCK=$HOME/.config/i3/lock.sh

if [ $RES = "lock" ]; then
    $LOCK
elif [ $RES = "logout" ]; then
    i3-msg exit
elif [ $RES = "restart" ]; then
    systemctl reboot
elif [ $RES = "suspend" ]; then
    $LOCK && systemctl suspend
elif [ $RES = "shutdown" ]; then
    systemctl poweroff
fi
exit 0
