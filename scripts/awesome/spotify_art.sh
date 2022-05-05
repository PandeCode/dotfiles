#!/bin/sh

defaultPlayer=spotify
defaultSink=spotify
currentPlayerFile=/tmp/currentPlayerFile
pictureCacheDir=~/.cache/spotifyPictureCache
imageSize=16x16
displayIcon=true

function getNewCurrentPlayer() {
	players=$(playerctl -l)

	for p in $players; do
		if [ "$defaultPlayer" = "$p" ]; then
			echo -n $p > $currentPlayerFile
			echo -n $p
			return
		fi
	done

	for p in $players; do
		echo -n $p > $currentPlayerFile
		echo -n $p
		return
	done
}

function getCurrentPlayer() {

	if [ -f "$currentPlayerFile" ]; then
		c=$(cat $currentPlayerFile)
		players=($(playerctl -l))
		if [[ " ${players[*]} " =~ " ${c} " ]]; then
			echo -n $c
			return
		fi
	fi

	echo -n $(getNewCurrentPlayer)
}

function getAlbmuArt() {
	artUrl=$(playerctl metadata -p spotify --format "{{ mpris:artUrl }}")
	fileName=$(echo $artUrl | grep -Po '.*/\K.*')
	fileNameXpm="$(echo $fileName).xpm"

	if ! [ -f $pictureCacheDir/$fileName ]; then
		wget -O $pictureCacheDir/$fileName $artUrl

		cd $pictureCacheDir
		convert $fileName -resize $imageSize $fileNameXpm
	fi

	if ! [ -f $fileNameXpm ]; then
		cd $pictureCacheDir
		convert $fileName -resize $imageSize $fileNameXpm
	fi

	echo $pictureCacheDir/$fileNameXpm
}

function getAction() {
	if [ "$(playerctl status -p $(getCurrentPlayer))" == "Playing" ]; then
		echo "<action=\`playerctl pause -p $(getCurrentPlayer)\`>"
	else
		echo "<action=\`playerctl play -p $(getCurrentPlayer)\`>"
	fi
}

currentPlayer=$(getCurrentPlayer)

if [ "$displayIcon" = true ] && [ "$currentPlayer" = "spotify" ]; then
	echo -n "$(getAlbmuArt)"
fi

