#!/bin/bash
PRIMARY=$(grep "^    @define-color primary " ~/.config/waybar/colors.css | grep -o '#[0-9a-f]*')
SECONDARY=$(grep "^    @define-color secondary " ~/.config/waybar/colors.css | grep -o '#[0-9a-f]*')
TERTIARY=$(grep "^    @define-color tertiary " ~/.config/waybar/colors.css | grep -o '#[0-9a-f]*')
[ -z "$PRIMARY" ] && PRIMARY="#84d6c2"
[ -z "$SECONDARY" ] && SECONDARY="#b1ccc4"
[ -z "$TERTIARY" ] && TERTIARY="#c1c4eb"
# Set terminal colors 2 3 6 to primary secondary tertiary
printf "\033]4;2;${PRIMARY}\007"
printf "\033]4;3;${SECONDARY}\007"
printf "\033]4;6;${TERTIARY}\007"
pipes.sh -p 3 -t 0 -c 2 -c 3 -c 6 -f 30 -r 0 -R
