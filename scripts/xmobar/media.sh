#!/bin/env sh

case $1 in
	1)
		playerctl -p spotify play-pause
		;;

	2)
		;;

	3)
		cmd="$(
			cat << EOF | xmenu
Play-Pause	playerctl -p spotify play-pause
Next	playerctl -p spotify next
Previous	playerctl -p spotify previous
Play	playerctl -p spotify play
Pause	playerctl -p spotify pause
Stop	playerctl -p spotify stop
EOF
		)"

		;;

	4)
		pactl set-sink-volume @DEFAULT_SINK@ +10%
		;;

	5)
		pactl set-sink-volume @DEFAULT_SINK@ -10%
		;;
esac
