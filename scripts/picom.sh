#!/bin/sh

file=~/.config/picom/picom.conf

setCornerRadius() {
	perl -pe "s/(corner-radius =\s+)(\d+\.?\d?);/\1 $1;/" -i $file
}

setBlurStrength() {
	perl -pe "s/(  strength =\s+)(\d+\.?\d?);/\1 $1;/" -i $file
}

case $1 in
	radius)
		if [ "$2" -eq "$2" ] 2> /dev/null; then
			echo "$2 : is a number"
			current=$(cat $file | grep -Po "(?<=corner-radius = ).*(?=;)")
			echo Current: $current
			setCornerRadius $2
			echo New: $2
		else
			[ -n "$2" ] && echo "$2 : is EMPTY" && exit 1
			echo "$2 : not a number"
		fi
		;;
	rounded)
		current=$(cat $file | grep -Po "(?<=corner-radius = ).*(?=;)")
		if [ $(bc <<< "0==$current") == 1 ]; then
			echo Off: $current
			setCornerRadius 10
			echo On: 10
		else
			echo On: $current
			setCornerRadius 0
			echo Off: 0
		fi
		;;
	animation) ;;

	blur)
		if [ "$2" -eq "$2" ] 2> /dev/null; then
			current=$(cat $file | grep -Po "(?<=  strength = ).*(?=;)")
			echo Current: $current
			setBlurStrength $2
			echo New: $2
		else
			[ -n "$2" ] && echo "$2 : is EMPTY" && exit 1
			echo "$2 : not a number"
		fi
		;;

esac
