#!/bin/env sh

mediaIdFile=/tmp/mediaId
pictureCacheDir=~/.cache/spotifyPictureCache

if ! [ -d $pictureCacheDir ]; then
	mkdir -p $pictureCacheDir
fi

getAlbmuArt() {
	artUrl=$(playerctl metadata --format "{{ mpris:artUrl }}")
	fileName=$(echo $artUrl | grep -Po '.*/\K.*')

	if [ -f $pictureCacheDir/$fileName ]; then
		echo $pictureCacheDir/$fileName
	else
		wget -O $pictureCacheDir/$fileName $artUrl
		echo $pictureCacheDir/$fileName
	fi
}

getMedia() {
	if pgrep -x "spotify" > /dev/null; then
		playerctl -p spotify metadata --format \
			'{{ title }}
{{ artist }}
{{ album }}
{{ duration(position) }} / {{ duration(mpris:length) }}'
	else
		playerctl metadata --format \
			'{{ uc(playerName) }} {{status}}
{{title}} 
{{artist}}
{{album}}
{{ duration(position) }} / {{ duration(mpris:length) }}'
	fi
}

if pgrep -x "spotify" > /dev/null; then

	[ -z "$1" ] || playerctl $1 -p spotify

	replace=$(cat $mediaIdFile)
	if [ -z "$replace" ]; then
		notify-send.py -t 2000 "Media $1" "$(getMedia)" --hint string:image-path:file://$(getAlbmuArt) > $mediaIdFile
	else
		notify-send.py -t 2000 "Media $1" "$(getMedia)" -r $replace --hint string:image-path:file://$(getAlbmuArt) > $mediaIdFile
	fi

else
	[ -z "$1" ] || playerctl $1

	replace=$(cat $mediaIdFile)
	if [ -z "$replace" ]; then
		notify-send.py -t 2000 "Media $1" "$(getMedia)" > $mediaIdFile
	else
		notify-send.py -t 2000 "Media $1" "$(getMedia)" -r $replace > $mediaIdFile
	fi

fi
