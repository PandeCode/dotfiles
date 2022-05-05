#!/bin/env sh

lightIdFile=/tmp/lightId

lightNotify() {
	replace=$(cat $lightIdFile)
	if [ -z "$replace" ]
	then
		notify-send.py "Light $1" "$(light)" -t 1000 --hint float:value:$(light) > $lightIdFile
	else
		notify-send.py "Light $1" "$(light)" -t 1000 --hint float:value:$(light) -r $replace > $lightIdFile
	fi
}

lightUp() {
	light -A 5
}

lightDown() {
	light -U 5
}

lightOff() {
	xset dpms force off
}

case $1 in
	off)
		lightOff
		;;
	up)
		lightUp
		lightNotify Up
		;;
	down)
		lightDown
		lightNotify Down
		;;
esac
