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

function setCurrentPlayer() {
	echo -n $1 > $currentPlayerFile
}

function playerNotFound() {
	notify-send "Player Not Found" "Start a player like spotify or a youtube video." -u critical -t 3000
}

getSink() {
	pactl list sink-inputs |
		grep "\(Sink Input\|media.name\)" |
		perl -pe 's/(\t)//; s/\s*//; s/\n//; s/Sink Input #/\n/; s/^(\s|\t|\")*$//;s/"//; s/"// ;s/media.name = / /' |
		grep $1 |
		cut -d ' ' -f 1 | tr '
' ' ' | sed 's/ //'
}

getCurrnetSink() {
	getSink Spotify
}

case $1 in
	1)
		playerctl -p spotify play-pause
		exit 0
		;;

	2)
		~/dotfiles/scripts/dwm/media.sh
		#spotymenu
		exit 0
		;;

	3)
		players=""
		for p in $(playerctl -l); do players+="	$p	setCurrentPlayer $p > $currentPlayerFile
"; done

		if [ -z "$players" ]; then
			players='	None	playerNotFound'
		else
			players+="	"
		fi

		currentPlayer=$(getCurrentPlayer)

		cmd="$(
			cat << EOF | xmenu
Player
$players
	
Control
	Play-Pause	playerctl --player=$currentPlayer  play-pause
	Next    	playerctl --player=$currentPlayer  next
	Previous	playerctl --player=$currentPlayer  previous
	Play    	playerctl --player=$currentPlayer  play
	Pause   	playerctl --player=$currentPlayer  pause
	Stop    	playerctl --player=$currentPlayer  stop
EOF
		)"

		$cmd
		exit 0
		;;

	4)
		pactl set-sink-input-volume "$(getCurrnetSink)" +10%
		exit 0
		;;

	5)
		pactl set-sink-input-volume "$(getCurrnetSink)" -10%
		exit 0
		;;

	source)
		exit 0
		;;

esac

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

echo -n '<action=`~/dotfiles/scripts/xmobar/media.sh 2` button=2>'
echo -n '<action=`~/dotfiles/scripts/xmobar/media.sh 3` button=3>'
echo -n '<action=`~/dotfiles/scripts/xmobar/media.sh 4` button=4>'
echo -n '<action=`~/dotfiles/scripts/xmobar/media.sh 5` button=5>'

currentPlayer=$(getCurrentPlayer)

if [ "$displayIcon" = true ] && [ "$currentPlayer" = "spotify" ]; then
	echo -n '<icon='$(getAlbmuArt)'/> '
fi

info=$(playerctl metadata -p $currentPlayer --format '{{ artist }} ----- {{ title }}')

title="$(grep -Po '(?<=----- ).*' <<< $info)"
artist="$(grep -Po '.*(?= -----)' <<< $info)"

finalInfo=''

if ! [ -z "$artist" ]; then
	finalInfo+="$artist - "
fi

if ! [ -z "$title" ]; then
	finalInfo+="$(perl -pe 's/^Watch //; s/ English Subbed Online Free//' <<< $title)"
fi

echo -n "\
<action=\`playerctl play-pause -p $currentPlayer\`>\
$finalInfo</action>\
"

echo -n "\
<action=\`playerctl previous -p $currentPlayer\`>  </action>\
$(getAction)</action>\
<action=\`playerctl next -p $currentPlayer\`>  </action>\
"
echo -n '</action>'
echo -n '</action>'
echo -n '</action>'
echo -n '</action>'
