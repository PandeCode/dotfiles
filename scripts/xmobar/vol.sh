#!/bin/env sh

getVol() {
	amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $2 }'
}

isMuted() {
	pacmd list-sinks | awk '/muted/ { print $2 }'
}

volNotify() {
        notify-send 'Vol' -h int:value:$(pamixer --get-volume)
}

volMute() {
        pactl set-sink-mute @DEFAULT_SINK@ toggle
}

volUp() {
        pactl set-sink-volume @DEFAULT_SINK@ +10%
}

volDown() {
        pactl set-sink-volume @DEFAULT_SINK@ -10%
}

case $1 in
	1)
		notify-send "Vol" "$(getVol)"
		exit 0
		;;

	2)
		pavucontrol
		exit 0
		;;

	3)
		cmd="$(
		cat << EOF | xmenu
Hello	World
EOF
		)"

		;;

	4)
		volUp
		;;

	5)
		volDown
		;;
esac
