#!/bin/env sh

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
	up)
		volUp
		volNotify
		;;
	down)
		volDown
		volNotify
		;;
	mute)
		volMute
		volNotify
		;;

esac
