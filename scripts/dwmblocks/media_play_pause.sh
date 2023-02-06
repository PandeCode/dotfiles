#!/bin/sh

LC_ALL=en_US.UTF-8
index=37 # 34+3
killall -$index $(pidof dwmblocks)

source $DOTFILES/scripts/shared/media.sh

case $BUTTON in
	1)
		killall -$index $(pidof dwmblocks)

		if [ "$currentStatus" == "Playing" ]; then
			playerctlCommandCurrentPlayerOrDefault pause
		else
			playerctlCommandCurrentPlayerOrDefault play
		fi

		exit 0
		;;

	2)
		killall -$index $(pidof dwmblocks)
		notify-send "$(echo media)" "$(echo $BUTTON)"
		exit 0
		;;

	3)
		killall -$index $(pidof dwmblocks)
		notify-send "$(echo media)" "$(echo $BUTTON)"
		cmd="$(
			cat << EOF | xmenu
Media
EOF
		)"

		case $cmd in
			"Media")
				notify-send "$(echo media)" "$(echo $BUTTON)"
				;;
			*)
				notify-send "$(echo media)" "$(echo $BUTTON)"
				;;
		esac

		exit 0
		;;

esac

if [ "$currentStatus" == "Playing" ]; then
	echo -n " ";
else
	echo -n " "
fi

