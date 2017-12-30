#!/bin/bash

RES=$(echo "Lock|Suspend|Logout|Restart|Grub index:|Hibernate|Shutdown" | rofi -dmenu -i -sep "|" -p 'Power Menu: ' "" -width 16 -lines 7 -eh 1 -hide-scrollbar -padding 20)
LOCK=$HOME/.config/i3/lock.sh
ERROR_MSG="Power menu: invalid input"

if [[ $RES = "" ]]; then
    exit 0
fi

if [[ $RES = "Lock" ]]; then
    $LOCK --nofork
elif [[ $RES = "Logout" ]]; then
    i3-msg exit
elif [[ $RES = "Suspend" ]]; then
    $LOCK && systemctl suspend
elif [[ $RES = "Restart" ]]; then
    systemctl reboot
elif [[ $RES = "Grub index:"* ]]; then
    index=$(echo $RES | cut -d':' -f 2)
    if [[ $index =~ ^[0-9]+$ ]]; then
        gksu grub-reboot $index && systemctl reboot
    else
        notify-send "$ERROR_MSG for grub reboot"
    fi
elif [[ $RES = "Hibernate" ]]; then
    $LOCK && systemctl hibernate
elif [[ $RES = "Shutdown" ]]; then
    systemctl poweroff
else
    notify-send "$ERROR_MSG"
fi

exit 0
