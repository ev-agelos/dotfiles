#!/bin/bash

res=$(echo "lock|logout|restart|suspend|shutdown" | rofi -dmenu -i -sep "|" -p 'Power Menu: ' "" -width 16 -eh 1 -hide-scrollbar -padding 20 -font "Awesome 10, Hack 15")

if [ $res = "lock" ]; then
    $HOME/.config/i3/lock.sh
fi
if [ $res = "logout" ]; then
    i3-msg exit
fi
if [ $res = "restart" ]; then
    systemctl reboot
fi
if [ $res = "suspend" ]; then
    systemctl suspend
fi
if [ $res = "shutdown" ]; then
    systemctl poweroff
fi
exit 0
