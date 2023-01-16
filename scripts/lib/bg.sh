#!/bin/env sh

img_log_file=~/log/img.log
img_dir=/home/shawn/Pictures/Wallpapers
img_file_index=~/.cache/imgIndex.txt

sed -i '/^$/d' $img_log_file

if [ ! -f $img_log_file ]; then
	mkdir -p "$(dirname "$img_log_file")"
	touch $img_log_file
fi

if [ ! -f $img_file_index ]; then
	ls -1 $img_dir/* > $img_file_index
fi

function setbg (){
	img=$1
	if ! [ -f "$img" ]; then
		notify-send "Image file does not exist '$img'"
		echo "Image file does not exist '$img'" &1>2
	fi

	if [[ "$XDG_SESSION_TYPE" == "x11" ]]; then
		feh --bg-fill $img
		echo "$img"
		echo "$img" >> $img_log_file
	elif [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
		killall -9 swaybg 2> /dev/null
		swaybg -i "$img" -m fill 1>&2 2> /dev/null & disown
		echo "$img"
		echo "$img" >> $img_log_file
	else
		echo "No XDG_SESSION_TYPE:'$XDG_SESSION_TYPE'"
	fi
}


