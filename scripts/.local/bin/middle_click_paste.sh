# Make sure `save_to_clipboard` is `false` in alacritty config file.

# Copy text within alacritty only in the primary selection.
# Because when something is copied from outside,
# is copied in both primary and clipboard, when we copy within alacritty
# send it only in primary selection so we can distinguish if we want to
# paste (from outside) or send the copied text in the browser.

primary=$(xclip -o -selection primary)
clipboard=$(xclip -o -selection clipboard)
if [ $primary = $clipboard ]; then
    xdotool key ctrl+shift+v
    exit 0
fi

workspace=$(wmctrl -d | awk '{ if ($2 == "*") print $1}')
applications=$(wmctrl -lG | awk -v w="$workspace" '$2 == w {print $0}')
opened_browsers=$(awk '$NF=="Brave" || $NF=="Firefox" || $NF=="Chromium" || $NF=="qutebrowser" {print $0}' <<< "$applications")
[ ! -n "$opened_browsers" ] && ("$BROWSER" "$(command -v xclip > /dev/null && xclip -o || xsel -o)" &) && exit 0

largest_browser=$(echo "$opened_browsers" | sort -k5 -k6 -n | tail -1)
browser_name=$(echo "$largest_browser" | rev | cut -d' ' -f1 | rev)
browser_id=$(echo "$largest_browser" | cut -d' ' -f1)

# pipe text from primary to clipboard
xclip -o -selection primary | xclip -in -selection clipboard

wmctrl -ia "$browser_id"
if [ "$browser_name" == "qutebrowser" ]; then
    xdotool key Escape shift+o ctrl+v KP_Enter
else
    xdotool key ctrl+t ctrl+v KP_Enter
fi
