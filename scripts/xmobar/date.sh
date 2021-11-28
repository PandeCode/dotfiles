#!/bin/sh


case $1 in
	1)
		notify-send "$(cal)" -t 3000
		exit 0
		;;
	2)
		xclock
		exit 0
		;;
	3)
		notify-send "Date" "$1" -t 3000
		exit 0
		;;
esac
