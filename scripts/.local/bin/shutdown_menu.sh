#!/bin/bash

OPTION=$(echo -e "Lock\nSuspend\nLogout\nRestart\nGrub index:\nHibernate\nShutdown" | dmenu -i -l 7)
LOCK=$HOME/.local/bin/lock.sh
ERROR_MSG="Power menu: invalid input"

if [[ $OPTION = "" ]]; then
    exit 0
fi

if [[ $OPTION = "Lock" ]]; then
    $LOCK --nofork
elif [[ $OPTION = "Logout" ]]; then
    i3-msg exit
elif [[ $OPTION = "Suspend" ]]; then
    $LOCK && systemctl suspend
elif [[ $OPTION = "Restart" ]]; then
    systemctl reboot
elif [[ $OPTION = "Grub index:"* ]]; then
    index=$(echo $OPTION | cut -d':' -f 2)
    if [[ $index =~ ^[0-9]+$ ]]; then
        gksu grub-reboot $index && systemctl reboot
    else
        notify-send "$ERROR_MSG for grub reboot"
    fi
elif [[ $OPTION = "Hibernate" ]]; then
    $LOCK && systemctl hibernate
elif [[ $OPTION = "Shutdown" ]]; then
    systemctl poweroff
else
    notify-send "$ERROR_MSG"
fi

exit 0
