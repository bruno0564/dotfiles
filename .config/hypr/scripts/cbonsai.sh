#!/bin/bash
PRIMARY=$(grep "^    @define-color primary " ~/.config/waybar/colors.css | grep -o '#[0-9a-f]*')
TERTIARY=$(grep "^    @define-color tertiary " ~/.config/waybar/colors.css | grep -o '#[0-9a-f]*')
ON_PRIMARY=$(grep "^    @define-color on_primary_container " ~/.config/waybar/colors.css | grep -o '#[0-9a-f]*')
TERTIARY_FIXED=$(grep "^    @define-color tertiary_fixed " ~/.config/waybar/colors.css | grep -o '#[0-9a-f]*')
[ -z "$PRIMARY" ] && PRIMARY="#84d6c2"
[ -z "$TERTIARY" ] && TERTIARY="#c1c4eb"
[ -z "$ON_PRIMARY" ] && ON_PRIMARY="#a0f2de"
[ -z "$TERTIARY_FIXED" ] && TERTIARY_FIXED="#dfe0ff"
# dark leaves, dark wood, light leaves, light wood
printf "\033]4;2;${PRIMARY}\007"
printf "\033]4;3;${ON_PRIMARY}\007"
printf "\033]4;10;${TERTIARY}\007"
printf "\033]4;11;${TERTIARY_FIXED}\007"
cbonsai --live --infinite --time=1.8 --wait=3600 --life=200 --multiplier=8 --leaf="&,+,*" -k 2,3,10,11
