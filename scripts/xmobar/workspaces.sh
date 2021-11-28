#!/bin/sh

#notify-send Workspace "$1 $2" -t 500 -u low
#notify-send Workspace "$1 $2" -t 500 -u normal

workspace=$1
button=$2

case $button in
	1)
		# Left click
		# in theory should never be called
		;;

	2) # MiddleClick

		;;

	3) # Right Click
		# Move Current Workspace Windows to Clicked Workspace
		# Kill All Windows Workspaces but Clicked Workspace
		# Kill All Windows in Clicked Workspace

		cmd="$(
		cat << EOF | xmenu
Hello
EOF
		)"

		$cmd

		;;

	4) #  Scroll Up
		if [ $workspace -lt 9 ]; then
			xdotool set_desktop $(bc <<< "$(xdotool get_desktop) + 1")
		fi
		;;

	5) #  Scroll Down
		if [ $workspace -gt 1 ]; then
			xdotool set_desktop $(bc <<< "$(xdotool get_desktop) - 1")
		fi
		;;

	*)
		notify-send "Workspace Unimplemented" "$1 $2" -t 500 -u critical
		;;
esac
