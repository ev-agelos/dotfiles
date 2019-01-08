#!/usr/bin/env bash

colors=$(kitty @ get-colors | grep -e "^background \|^foreground " | cut -d ' ' -f15)

case "$colors" in
*262626*)
    ;&
*dddddd*)
    kitty @ set-colors --all --configured foreground=#222222 background=#F1F1F1
	;;
*)
    kitty @ set-colors --reset
    ;;
esac
