#!/bin/sh

index=35 # 34+1
killall -$index $(pidof dwmblocks)

source $DOTFILES/scripts/shared/media.sh

LC_ALL=en_US.UTF-8
case $BUTTON in
	1)
		pkill -$index dwmblocks
		playerctlCommandCurrentPlayerOrDefault play-pause
		exit 0
		;;

	2)
		pkill -$index dwmblocks
		exit 0
		;;

	3)
		pkill -$index dwmblocks
		notify-send "Media" "$BUTTON"
		cmd="$(
			cat << EOF | xmenu
Media
EOF
		)"

		case $cmd in
			"Media") 
		notify-send "Media" "$BUTTON"
				;;
			*)
		notify-send "Media" "Button: $BUTTON"
				;;
		esac

		exit 0
		;;

esac

echo "^c#55cdfc^^r10,3,3,14,14^^f20^$currentSong"
