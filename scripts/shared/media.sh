defaultPlayer=spotify
currentPlayerFile=/tmp/currentPlayerFile
pictureCacheDir=~/.cache/spotifyPictureCache
imageSize=16x16

function getAlbmuArt() {
	artUrl=$(playerctl metadata -p spotify --format "{{ mpris:artUrl }}")
	fileName=$(echo "$artUrl" | grep -Po '.*/\K.*')
	fileNameXpm="$fileName.xpm"
	fileNameAbs="$pictureCacheDir/$fileName"
	fileNameAbsXpm="$pictureCacheDir/$fileName.xpm"

	if ! [ -f "$fileNameAbs" ]; then
		safeCd "$pictureCacheDir"
		wget -O "$fileNameAbs" "$artUrl"
		convert "$fileName" -resize $imageSize "$fileNameXpm"
	fi
	if ! [ -f "$fileNameXpm" ]; then
		safeCd $pictureCacheDir
		convert "$fileName" -resize $imageSize "$fileNameXpm"
	fi

	echo "$fileNameAbsXpm"
}


function getNewCurrentPlayer() {
	players=$(playerctl -l)

	for p in $players; do
		if [ "$defaultPlayer" = "$p" ]; then
			echo -n "$p" > $currentPlayerFile
			echo -n "$p"
			return
		fi
	done

	for p in $players; do
		echo -n "$p" > $currentPlayerFile
		echo -n "$p"
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

function setCurrentPlayer() {
	echo -n $1 > $currentPlayerFile
}

function playerNotFound() {
	notify-send "Player Not Found" "Start a player like spotify or a youtube video." -u critical -t 3000
}

function playerctlCommandCurrentPlayerOrDefault() {
	currentPlayer=$(getCurrentPlayer)
	if [ "$currentPlayer" = "spotify" ]; then
		playerctl -p "$(getCurrentPlayer)" $1
	else
		playerctl $1
	fi
}

currentPlayer=$(getCurrentPlayer)
currentStatus=$(playerctl -p "$currentPlayer" status)
currentSong="$(playerctl metadata -p $(getCurrentPlayer) -f '{{artist}} - {{title}}')"

