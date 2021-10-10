#!/bin/env sh

case $BUTTON in
	1) notify-send "$(cal)";;
	2) notify-send "Date" "$BUTTON";;
	3) notify-send "Date" "$BUTTON";;
esac
