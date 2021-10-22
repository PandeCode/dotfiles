#!/bin/env sh

case $BUTTON in
	1) notify-send "BAT" "$(acpi)" ;;

	2) st -e htop ;;

	3)
		cmd="$(
			cat << EOF | xmenu
Light UP	light -S 100
Light HALF	light -S 50
Light DOWN	light -S 1
Extreme Save	light -S 1; killall -9 chrome picom xflux nm-applet clipit
EOF
		)"
		$cmd
		notify-send "$cmd"
		;;
esac
