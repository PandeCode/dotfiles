#!/bin/sh
# Media Previous Button

index=36 # 34+2
killall -$index $(pidof dwmblocks)

source ~/dotfiles/scripts/shared/media.sh

LC_ALL=en_US.UTF-8
case $BUTTON in
	1)
		playerctlCommandCurrentPlayerOrDefault previous

		exit 0
		;;

	2)
		BUTTON=2 ~/dotfiles/scripts/dwmblocks/media_info.sh
		exit 0
		;;

	3)
		BUTTON=3 ~/dotfiles/scripts/dwmblocks/media_info.sh
		exit 0
		;;

esac

echo "  "
