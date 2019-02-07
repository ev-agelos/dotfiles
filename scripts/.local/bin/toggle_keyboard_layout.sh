current_layout=$(setxkbmap -query | grep layout | sed 's/layout.* //g')

if [ $current_layout = "us" ]; then
    new_layout='gr '
    flag='🇬🇷'
else
    new_layout='us ';
    flag='🇺🇸'
fi

setxkbmap $new_layout
notify-send "Keyboard layout:" "$new_layout $flag"
paplay ~/.local/bin/notification.oga
