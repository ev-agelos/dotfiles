#  Taken from stackoverflow: https://superuser.com/a/398990
#  will source the .profile file with zsh's sh-mode in effect.  And it's only active during the source.
#  So you do not have to save the current option state in order to replay it again after sourcing.
[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'

# MPD daemon start (if no other user instance exists)
[ ! -s ~/.config/mpd/pid ] && mpd

if [ -z "$DISPLAY" -a "$XDG_VTNR" -eq 1 ]; then
  export XAUTHORITY=$XDG_RUNTIME_DIR/Xauthority
  exec startx $XDG_CONFIG_HOME/X11/xinitrc 2> /tmp/xsession-errors
fi

# if [[ -z $DISPLAY && $(tty) == /dev/tty1 && $XDG_SESSION_TYPE == tty ]]; then
#     export XDG_SESSION_TYPE=wayland
#     # enable experimental wayland support for firefox
#     export MOZ_ENABLE_WAYLAND=1
#     exec sway 2>/tmp/sway-errors
# fi
