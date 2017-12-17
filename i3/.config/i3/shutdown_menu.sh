#!/bin/bash

RES=$(echo "lock|logout|suspend|restart|grub reboot:|hibernate|shutdown" | rofi -dmenu -i -sep "|" -p 'Power Menu: ' "" -width 16 -lines 7 -eh 1 -hide-scrollbar -padding 20 -font "Awesome 10, Hack 15")
LOCK=$HOME/.config/i3/lock.sh
ERROR_MSG="Power menu: invalid input"

if [[ $RES = "lock" ]]; then
    $LOCK --nofork
elif [[ $RES = "logout" ]]; then
    i3-msg exit
elif [[ $RES = "suspend" ]]; then
    $LOCK && systemctl suspend
elif [[ $RES = "restart" ]]; then
    systemctl reboot
elif [[ $RES = "grub reboot:"* ]]; then
    index=$(echo $RES | cut -d':' -f 2)
    if [[ $index =~ ^[0-9]+$ ]]; then
        gksu grub-reboot $index && systemctl reboot
    else
        notify-send "$ERROR_MSG for grub reboot"
    fi
elif [[ $RES = "hibernate" ]]; then
    $LOCK && systemctl hibernate
elif [[ $RES = "shutdown" ]]; then
    systemctl poweroff
else
    notify-send "$ERROR_MSG"
fi
exit 0
