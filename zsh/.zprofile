#  Taken from stackoverflow: https://superuser.com/a/398990
#  will source the .profile file with zsh's sh-mode in effect.  And it's only active during the source.
#  So you do not have to save the current option state in order to replay it again after sourcing.
[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'

if [ -z "$DISPLAY" -a $XDG_VTNR -eq 1 ]; then
  exec startx 2>.xsession-errors
fi
