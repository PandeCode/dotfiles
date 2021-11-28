#!/bin/sh

case $1 in
	1)
		notify-send "BAT" "$(acpi) 
Light: $(light)" -t 2000
		exit 0
		;;

	2)
		st -e htop
		exit 0
		;;

	3)
		cmd="$(
			cat << EOF | xmenu
Light
	100	light -S 100
	75	light -S 75
	50	light -S 50
	25	light -S 25
	10	light -S 10
	5	light -S 5
	1	light -S 1
	
Extreme Save	light -S 1; killall -9 chrome picom xflux nm-applet clipit;
EOF
			exit 0
		)"
		$cmd
		notify-send "$cmd" -t 500

		exit 0
		;;
	4)
		if ! [ "100.00" = "$(light)" ]; then
			~/dotfiles/scripts/dwm/light.sh up
		fi
		;;
	5)
		if [ "0.00" = "$(light)" ]; then
			~/dotfiles/scripts/dwm/light.sh up
		elif ! [ "5.00" = "$(light)" ]; then
			~/dotfiles/scripts/dwm/light.sh down
		fi
		;;
esac
