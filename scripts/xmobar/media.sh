#!/bin/sh

defaultPlayer=spotify
defaultSink=spotify
currentSinkFile=/tmp/currentSinkFile
currentPlayerFile=/tmp/currentPlayerFile
pictureCacheDir=~/.cache/spotifyPictureCache
imageSize=16x16
displayIcon=true
progressWidth=2
progressPosition=Bottom # Top | Bottom
progressColor="#84ffff"

DELIMITER_1="🗘" # It is there just not rendered easily

function makeSafeForSed (){
	str="$1"
	strlen=${#str}
	for (( i=0; i< ${strlen}; i++ )); do
		char=${str:$i:1}
		if [ "$char" == "/" ];then
			echo -n "\\/"
		else
			echo -n $char
		fi
	done
}

function isProcessRunning() {
	pid=$1
	kill -0 $pid 2> /dev/null
	return $?
}

function applyProgress () {
	info=$1
	infoLen=${#info}
	data=$( playerctl metadata -p $currentPlayer -f '{{ position }} {{ mpris:length }}' )
	length=$(echo -n "$data" | awk '{print $2}')
	numChars=$(echo -n "$data" | awk "{ printf(\"%.f\", $infoLen * (\$1/\$2))}" )

	first=""
	second=""
	for (( i=0; i < infoLen; i++ )); do
		char=${info:$i:1}
		seek=$(echo -n "$i $infoLen" | awk "{ printf(\"%.f\", 0.000001*($length*($i/$infoLen)))}")

		if (( $i > $numChars )); then
			second+="<action=\`playerctl -p $currentPlayer position $seek\`>$char</action>"
		else
			first+="<action=\`playerctl -p $currentPlayer position $seek\`>$char</action>"
		fi
	done

	echo -n "<box type=$progressPosition width=$progressWidth color=$progressColor>$first</box>$second"
}

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

currentPlayer=$(getCurrentPlayer)

function setCurrentPlayer() {
	echo -n $1 > $currentPlayerFile
}

function playerNotFound() {
	notify-send "Player Not Found" "Start a player like spotify or a youtube video." -u critical -t 3000
}

function sinkNotFound() {
	notify-send "Sink Not Found" "Start a player like spotify or a youtube video." -u critical -t 3000
}

function setCurrentSink() {
	echo -n $1 > $currentSinkFile
}

function getSink() {
	pactl list sink-inputs |
		grep "\(Sink Input\|media.name\)" |
		perl -pe 's/(\t)//; s/\s*//; s/\n//; s/Sink Input #/\n/; s/^(\s|\t|\")*$//;s/"//; s/"// ;s/media.name = / /' |
		grep $1 |
		cut -d ' ' -f 1 | tr '
' ' ' | sed 's/ //'

	if [ $? -ne 0 ]; then
		sinkNotFound
		setCurrentSink $defaultSink
	fi
}

function getSinks() {
	pactl list sink-inputs |
		grep "\(Sink Input\|media.name\)" |
		perl -pe 's/(\t)//; s/\s*//; s/\n//; s/Sink Input #/\n/; s/^(\s|\t|\")*$//;s/"//; s/"// ;s/media.name = / /' | sed -r '/^\s*$/d'
}

function getCurrentSink() {
	if [ -f "$currentSinkFile" ]; then
		cat $currentSinkFile
	else
		setCurrentSink $(getSink Spotify)
		echo -n Spotify | tee $currentSinkFile
	fi
}

case $1 in
	1)
		playerctl -p $currentPlayer play-pause
		exit 0
		;;

	2)
		$DOTFILES/scripts/dwm/media.sh
		#spotymenu
		exit 0
		;;

	3)
		players=""
		for p in $(playerctl -l); do
			players+="	$p	setCurrentPlayer $p > $currentPlayerFile
"
		done
		if [ -z "$players" ]; then
			players='	None	playerNotFound'
		else
			players+="	"
		fi

		sinks=""
		while IFS= read -r line; do
    		sinkNumber=$(echo $line | awk '{print($1)}')
    		sinkName=$(echo $line | awk '{print($2)}')
			sinks+="	$sinkName	setCurrentSink $sinkNumber > $currentSinkFile"
		done <<< "$(getSinks)"


		if [ -z "$sinks" ]; then
			sinks='	None	sinkNotFound'
		else
			sinks+="	"
		fi


		cmd="$(
			cat << EOF | xmenu
Player
$players
	
Sinks
$sinks
	
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
		pactl set-sink-input-volume "$(getCurrentSink)" +10%
		exit 0
		;;

	5)
		pactl set-sink-input-volume "$(getCurrentSink)" -10%
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
	if [ "$(playerctl status -p $currentPlayer)" == "Playing" ]; then
		echo "<action=\`playerctl pause -p $currentPlayer\`>"
	else
		echo "<action=\`playerctl play -p $currentPlayer\`>"
	fi
}

echo -n '<action=`$DOTFILES/scripts/xmobar/media.sh 2` button=2><action=`$DOTFILES/scripts/xmobar/media.sh 3` button=3><action=`$DOTFILES/scripts/xmobar/media.sh 4` button=4><action=`$DOTFILES/scripts/xmobar/media.sh 5` button=5>'
echo -n "<action=\`playerctl previous -p $currentPlayer\`>  </action>\
$(getAction)</action>\
<action=\`playerctl next -p $currentPlayer\`>  </action>"

iconText=''

if [ "$displayIcon" = true ] && [ "$currentPlayer" = "spotify" ]; then
	iconText="$(echo -n '<icon='$(getAlbmuArt)'/> ')"
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

progressedInfo=$(applyProgress "$DELIMITER_1$finalInfo")

echo -n "$progressedInfo" | sed "s/$DELIMITER_1/$(makeSafeForSed $iconText)/"

echo -n "\
</action>\
</action>\
</action>\
</action>\
"
