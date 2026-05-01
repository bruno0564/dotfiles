#!/bin/bash
PRIMARY=$(grep "^    @define-color primary " ~/.config/waybar/colors.css | grep -o '#[0-9a-f]*')
[ -z "$PRIMARY" ] && PRIMARY="#84d6c2"
# Set terminal color 6 to primary hex (kitty supports OSC 4)
printf "\033]4;6;${PRIMARY}\007"
tty-clock -c -s -b -C 6
