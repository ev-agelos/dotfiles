#!/bin/bash
pac=$(yay -Pn 2> /dev/null)
aur=$(cower -u 2> /dev/null | wc -l)

echo "$pac %{F#5b5b5b}%{F-} $aur"
