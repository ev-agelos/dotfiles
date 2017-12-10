#!/bin/sh

# /etc/X11/xinit/xinitrc
#
# global xinitrc file, used by all X sessions started by xinit (startx)

# invoke global X session script
#. /etc/X11/Xsession

if [ -d /etc/X11/xinit/xinitrc.d ]; then
for f in /etc/X11/xinit/xinitrc.d/*; do
[ -x "$f" ] && . "$f"
done
unset f
fi

sleep 5
# faster cursor
xset r rate 200 30
# map CapsLock -> Ctrl when pressed, Esc when tapped
setxkbmap -option 'caps:ctrl_modifier'
xcape -e 'Caps_Lock=Escape'


#compton --config "$HOME/.config/compton" &
xrdb -load "$HOME/.Xresources"
xset +fp "$HOME/.fonts"
xset fp rehash
pulseaudio --start
exec i3

