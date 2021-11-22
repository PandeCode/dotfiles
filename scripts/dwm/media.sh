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
"Title   {{ title }}
Album    {{ album }}
Artist   {{ artist }}
Position {{ duration(position) }}/{{ duration(mpris:length) }}"
	else
		playerctl metadata --format \
			'Status  {{status}}
Player   {{playerName}}
Position {{position}}
Volume   {{volume}}
Album    {{album}}
Artist   {{artist}}
Title    {{title}}'
	fi
}

if pgrep -x "spotify" > /dev/null; then
	playerctl $1 -p spotify

	if [ -f "$spotifyAlbumArtId" ]; then :; else
		playerctl -p spotify metadata --format "{{ mpris:artUrl }}" > $spotifyAlbumArtId
	fi
	if [ -f "$spotifyAlbumArt" ]; then :; else
		getAlbmuArt
	fi

	newMd=$(playerctl -p spotify metadata --format "{{ mpris:artUrl }}")

	if ! [ "$newMd" == "$(cat $spotifyAlbumArtId)" ]; then
		getAlbmuArt
		echo -n "$newMd"> $spotifyAlbumArtId
	fi

	replace=$(cat $mediaIdFile)
	if [ -z "$replace" ]; then
		notify-send.py "Media $1" "$(getMedia)" --hint string:image-path:file://$spotifyAlbumArt > $mediaIdFile
	else
		notify-send.py "Media $1" "$(getMedia)" -r $replace --hint string:image-path:file://$spotifyAlbumArt > $mediaIdFile
	fi

else

	playerctl $1

	replace=$(cat $mediaIdFile)
	if [ -z "$replace" ]; then
		notify-send.py "Media $1" "$(getMedia)" > $mediaIdFile
	else
		notify-send.py "Media $1" "$(getMedia)" -r $replace > $mediaIdFile
	fi

fi
