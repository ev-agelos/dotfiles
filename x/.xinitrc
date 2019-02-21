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

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# use gnome-keyring
dbus-update-activation-environment --systemd DISPLAY
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# program auto-mount usb
udiskie --no-automount --no-notify --tray --use-udisks2 &

# Set us as keyboard layout
setxkbmap -model pc105 -layout us

# faster cursor
xset r rate 200 100

# map CapsLock -> Ctrl when pressed, Esc when tapped
setxkbmap -option 'caps:ctrl_modifier'
xcape -e 'Caps_Lock=Escape'
xbindkeys -p

# include ~/.fonts directory for fonts
xset +fp "$HOME/.fonts"
xset fp rehash

xset -dpms && xset s noblank && xset s off

$(which pcloud) &
redshift &

xautolock -detectsleep -time 2 -notify 15 -notifier "notify-send -u critical -t 15000 -- 'LOCKING in 15'" -locker "lock.sh --nofork" &

# set the first (non HDMI) monitor as primary
xrandr --listactivemonitors | grep -P '^ [0-9]: \+\*?(?!HDMI)' | cut -d' ' -f6 | xargs -n1 -I '{}' xrandr --output {} --primary

exec i3

