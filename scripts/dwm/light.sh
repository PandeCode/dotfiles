#!/bin/env sh

lightNotify() {
	notify-send 'Light:' -h int:value:$(light)
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
		lightNotify
		;;
	down)
		lightDown
		lightNotify
		;;
esac
