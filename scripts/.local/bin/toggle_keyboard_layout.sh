current_layout=$(setxkbmap -query | grep layout | sed 's/layout.* //g')

if [ $current_layout = "us" ]; then
    new_layout='gr '
    flag='🇬🇷'
else
    new_layout='us ';
    flag='🇺🇸'
fi

setxkbmap $new_layout
pkill -RTMIN+12 i3blocks  # update i3blocks
notify-send "Keyboard layout: $new_layout $flag"
# play the first sound it finds in /usr/share/sounds/
pacmd play-file $(find /usr/share/sounds/**/*.ogg -print -quit) 0
