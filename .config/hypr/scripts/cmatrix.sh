#!/bin/bash
PRIMARY=$(grep "^    @define-color primary " ~/.config/waybar/colors.css | grep -o '#[0-9a-f]*')
[ -z "$PRIMARY" ] && PRIMARY="#84d6c2"
# Set terminal color 2 to primary hex
printf "\033]4;2;${PRIMARY}\007"
cmatrix -b -u 2
