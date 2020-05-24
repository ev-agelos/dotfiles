#!/bin/bash

OPTION=$(echo -e "Lock\nSuspend\nLogout\nRestart\nGrub index:\nHibernate\nShutdown" | bemenu -i -l 7)
ERROR_MSG="Power menu: invalid input"

[[ $OPTION = "" ]] && exit 0

if [[ "$XDG_SESSION_TYPE" == 'wayland' ]]; then
    lock_arg=''
    suspend_arg='--daemonize'
else
    lock_arg='--nofork'
    suspend_arg=''
fi


if [[ $OPTION = "Lock" ]]; then
    lock.sh $lock_arg
elif [[ $OPTION = "Logout" ]]; then
    i3-msg exit
elif [[ $OPTION = "Suspend" ]]; then
    lock.sh $suspend_arg && systemctl suspend
elif [[ $OPTION = "Restart" ]]; then
    systemctl reboot
elif [[ $OPTION = "Grub index:"* ]]; then
    index=$(echo $OPTION | cut -d':' -f 2)
    if [[ $index =~ ^[0-9]+$ ]]; then
        pkexec grub-reboot $index && systemctl reboot
    else
        notify-send "$ERROR_MSG for grub reboot"
    fi
elif [[ $OPTION = "Hibernate" ]]; then
    lock.sh $suspend_arg && systemctl hibernate
elif [[ $OPTION = "Shutdown" ]]; then
    systemctl poweroff
else
    notify-send "$ERROR_MSG"
fi

exit 0
