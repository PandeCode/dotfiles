#!/bin/env sh

case $BUTTON in
	1) notify-send "BAT" "$(acpi)" ;;
	2) notify-send "BAT" "$BUTTON" ;;
	3) notify-send "BAT" "$BUTTON" ;;
esac
