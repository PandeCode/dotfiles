#!/bin/env sh

case $1 in
	1)
		kill -s USR1 $(pidof -s deadd-notification-center)
		;;

	2)
		notify-send "Unbound: " "Todo"
		;;

	3)
		~/dotfiles/PERSONAL_PATH/menu.sh
		;;

	4) : ;;
	5) : ;;
esac
