#!/bin/env bash

# https://github.com/dwyl/english-words
# https://github.com/defCoding/rofi-dictionary
# https://github.com/marvinkreis/rofi-json-dict

if [ -z "$DOTFILES" ] ;then
	DOTFILES=$HOME/dotfiles
fi


case "$1" in
	"ssh") rofi -show ssh -show-icons ;;
	"calc") rofi -show calc -show-icons ;;
	"window") rofi -show window -show-icons ;;
	"run" | "raise") rofi -combi-modi window#drun -show combi -modi combi -show-icons ;;
	"window_go") rofi -show window -show-icons ;;
	"window_bring")
		current_desktop=$(wmctrl -d | grep '*' | grep -Po '^\d')
		windows=$(wmctrl -l)
		notify-send $(echo "$windows" | perl -pe 's/\w+\s+\d\s+(\w|-)+\s+//' | rofi -dmenu)
		window_id=$(rofi)
		wmctrl -r $window_id -t $current_desktop
		;;
	"notes") rofi - ;;
	"org") rofi - ;;
	"scripts_dir") rofi ;;
	"layout") rofi ;;
	"man") man -k . | rofi -dmenu | awk '{  }' | xargs kitty -e man ;;
	"unicode") rofi ;;
	"emoji") rofi -show emoji;;
	"translate") rofi_trans verbose;;
	"power") rofi -show powermenu -modi powermenu:$DOTFILES/scripts/rofi/rofi-power-menu ;;
	"wm") rofi ;;
	"xmonad") rofi ;;
	"dwm") rofi ;;
	"sway") rofi ;;
	"hypr") rofi ;;
	"help") notify-send "Prompt.sh" "	/ ==> help
	w ==> window
	r ==> run
	s ==> ssh
	n ==> notes
	o ==> org
	d ==> scripts_dir
	l ==> layout
	m ==> man
	u ==> unicode
	e ==> emoji
	t ==> translate
	p ==> power
	x ==> hypr
	g ==> window_go
	b ==> window_bring";;
	*) notify-send "Prompt.sh" "invalid '$1'" ;;
esac
