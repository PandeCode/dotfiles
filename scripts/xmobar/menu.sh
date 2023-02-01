#!/bin/sh

case $1 in
	1)
		kill -s USR1 $(pidof -s deadd-notification-center)
		;;

	2)
		notify-send "Unbound: " "Menu $1" -u critical  -t 500
		;;

	3)
		$PERSONAL_PATH/menu.sh
		;;

	4) 

		notify-send "Unbound: " "Menu $1" -u critical  -t 500
		;;
	5) 

		notify-send "Unbound: " "Menu $1" -u critical  -t 500
		;;
esac
