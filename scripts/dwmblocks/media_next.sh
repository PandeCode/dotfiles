#!/bin/sh

index=38 # 34+4
killall -$index $(pidof dwmblocks)

source ~/dotfiles/scripts/shared/media.sh

LC_ALL=en_US.UTF-8
case $BUTTON in
	1)
		killall -$index $(pidof dwmblocks)
		playerctlCommandCurrentPlayerOrDefault next
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

echo "  | "

