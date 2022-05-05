defaultPlayer=spotify
currentPlayerFile=/tmp/currentPlayerFile
isMutedDueToAdFile=/tmp/isMutedDueToAdFile

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

