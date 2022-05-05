#!/bin/env sh

index=42 # 34+8

case $BUTTON in
	1)
		killall -$index $(pidof dwmblocks)
		notify-send "$(cal)"
		exit 0
		;;
	2)
		killall -$index $(pidof dwmblocks)
		notify-send "Date" "$BUTTON"
		exit 0
		;;
	3)
		killall -$index $(pidof dwmblocks)
		notify-send "Date" "$BUTTON"
		exit 0
		;;
esac

date '+%a %d %b %R'
