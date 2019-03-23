#!/usr/bin/env bash

colors=$(kitty @ get-colors | grep -e "^background \|^foreground " | cut -d ' ' -f15)

case "$colors" in
*000000*)
    ;&
*eaeaea*)
    kitty @ set-colors --all --configured ~/.config/kitty/pencil_light.conf
	;;
*)
    kitty @ set-colors --reset
    ;;
esac
