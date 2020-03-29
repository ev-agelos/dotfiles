workspace=$(wmctrl -d | awk '{ if ($2 == "*") print $1}')
applications=$(wmctrl -lG | awk -v w="$workspace" '$2 == w {print $0}')
opened_browsers=$(awk '$NF=="Brave" || $NF=="Firefox" || $NF=="Chromium" || $NF=="qutebrowser" {print $0}' <<< "$applications")
[ ! -n "$opened_browsers" ] && ("$BROWSER" "$(command -v xclip > /dev/null && xclip -o || xsel -o)" &) && exit 0

largest_browser=$(echo "$opened_browsers" | sort -k5 -k6 -n | tail -1)
browser_name=$(echo "$largest_browser" | rev | cut -d' ' -f1 | rev)
browser_id=$(echo "$largest_browser" | cut -d' ' -f1)

if [ "$browser_name" == "qutebrowser" ]; then
    wmctrl -ia "$browser_id" && xdotool key Escape shift+o ctrl+v KP_Enter &
else
    wmctrl -ia "$browser_id" && xdotool key ctrl+t ctrl+v KP_Enter &
fi
