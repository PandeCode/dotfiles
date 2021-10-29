#!/bin/env sh

case $BUTTON in
	1)
		notify-send "$(cal)"
		exit 0
		;;
	2)
		notify-send "Date" "$BUTTON"
		exit 0
		;;
	3)
		notify-send "Date" "$BUTTON"
		exit 0
		;;
esac

date '+%a %d %b %R'
