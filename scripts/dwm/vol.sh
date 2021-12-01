#!/bin/env sh

getVol() {
	pamixer --get-volume
}

volIdFile=/tmp/volId

volNotify() {
	replace=$(cat $volIdFile)
	if [ -z "$replace" ]
	then
		notify-send.py "Volume $1" "$(getVol)" -t 1000 --hint int:value:$(getVol) > $volIdFile
	else
		notify-send.py "Volume $1" "$(getVol)" -t 1000 --hint int:value:$(getVol) -r $replace > $volIdFile
	fi
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
		volNotify Up
		;;
	down)
		volDown
		volNotify Down
		;;
	mute)
		volMute
		volNotify Mute
		;;

esac
