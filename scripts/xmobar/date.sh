#!/bin/env sh


case $1 in
	1)
		notify-send "$(cal)"
		exit 0
		;;
	2)
		xclock
		exit 0
		;;
	3)
		notify-send "Date" "$1"
		exit 0
		;;
esac
