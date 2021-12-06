#!/bin/env sh

mediaIdFile=/tmp/medianotifyid
spotifyAlbumArt=/tmp/spotifyAlbumArt
spotifyAlbumArtId=/tmp/spotifyAlbumArtId

getAlbmuArt() {
	curl $(dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata' | egrep -A 1 "artUrl" | cut -b 44- | cut -d '"' -f 1 | egrep -v ^$) -o $spotifyAlbumArt
}

getMedia() {
	if pgrep -x "spotify" > /dev/null; then
		playerctl -p spotify metadata --format \
			"{{ title }}
{{ artist }}
{{ album }}
{{ duration(position) }}/{{ duration(mpris:length) }}"
	else
		playerctl metadata --format \
			'
{{playerName}}
{{status}}
{{volume}}
{{title}}
{{artist}}
{{album}}
{{position}}'
	fi
}

if pgrep -x "spotify" > /dev/null; then

	if ! [ -z "$1" ]; then
		playerctl $1 -p spotify
	fi

	if ! [ -f "$spotifyAlbumArtId" ]; then
		playerctl -p spotify metadata --format "{{ mpris:artUrl }}" > $spotifyAlbumArtId
	fi
	if ! [ -f "$spotifyAlbumArt" ]; then 
		getAlbmuArt
	fi

	newMd=$(playerctl -p spotify metadata --format "{{ mpris:artUrl }}")

	if ! [ "$newMd" == "$(cat $spotifyAlbumArtId)" ]; then
		getAlbmuArt
		echo -n "$newMd" > $spotifyAlbumArtId
	fi

	replace=$(cat $mediaIdFile)
	if [ -z "$replace" ]; then
		notify-send.py -t 2000 "Media $1" "$(getMedia)" --hint string:image-path:file://$spotifyAlbumArt > $mediaIdFile
	else
		notify-send.py -t 2000 "Media $1" "$(getMedia)" -r $replace --hint string:image-path:file://$spotifyAlbumArt > $mediaIdFile
	fi

else

	playerctl $1

	replace=$(cat $mediaIdFile)
	if [ -z "$replace" ]; then
		notify-send.py -t 2000 "Media $1" "$(getMedia)" > $mediaIdFile
	else
		notify-send.py -t 2000 "Media $1" "$(getMedia)" -r $replace > $mediaIdFile
	fi

fi
