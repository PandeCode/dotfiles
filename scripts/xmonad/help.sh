#!/bin/bash

case "$1" in
	1)
		notify-send "item = 1"
	;;
	2|3)
		notify-send "item = 2 or item = 3"
	;;
	*)
		notify-send "default (none of above)"
	;;
esac

