#!/bin/sh

data=$(slop -b 3 -c 0.96,0.5,0.09 -t 0 -f "%x %y %w %h")

X=$(echo $data | awk '{ print($1) }')
Y=$(echo $data | awk '{ print($2) }')
WIDTH=$(echo $data | awk '{ print($3) }')
HEIGHT=$(echo $data | awk '{ print($4) }')

i3-msg focus prev
i3-msg floating enable
i3-msg move window position $X $Y
i3-msg resize set $WIDTH $HEIGHT
