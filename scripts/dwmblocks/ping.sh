#!/bin/env sh

index=39 # 34+5
killall -$index $(pidof dwmblocks)

__netUpdate() {
	sum=0
	for arg; do
		read -r i < "$arg"
		sum=$((sum + i))
	done
	cache=${XDG_CACHE_HOME:-$HOME/.cache}/${1##*/}
	[ -f "$cache" ] && read -r old < "$cache" || old=0
	printf %d\\n "$sum" > "$cache"
	printf %d\\n $((sum - old))
}

netTraf() {
	rx=$(__netUpdate /sys/class/net/[ew]*/statistics/rx_bytes)
	tx=$(__netUpdate /sys/class/net/[ew]*/statistics/tx_bytes)

	echo "🔻$(numfmt --to=iec $rx)B 🔺$(numfmt --to=iec $tx)B"
}

wirelessStrength() {
	echo $(awk '/^\s*w/ { print "📶", int($3 * 100 / 70) "% " }' /proc/net/wireless)
}
host() {
	echo $(cat $DOTFILES/extras/ping.host)
}
uploaded() {
	echo Uploaded: $($DOTFILES/scripts/upload_bytes.sh)
}
downloaded() {
	echo Downloaded: $($DOTFILES/scripts/download_bytes.sh)
}

case $BUTTON in
	1)
		killall -$index $(pidof dwmblocks)
		notify-send "Ping" "$(echo "$(iwgetid)\n$(netTraf)\n$(wirelessStrength)\n$(host)\n$(uploaded)\n$(downloaded)")"
		exit 0
		;;
	2)
		killall -$index $(pidof dwmblocks)
		xdg-open "http://$(ip route | grep default | grep -Eo '[0-9]+.[0-9]+.[0-9]+.[0-9]+')"
		exit 0
		;;
	3)

		cmd="$(
			cat << EOF | xmenu
9.9.9.9	9.9.9.9
8.8.8.8	8.8.8.8
LOL EUW1	dynamodb.eu-west-2.amazonaws.com
EOF
		)"
		if [ -z "$cmd" ]; then exit 0; fi
		echo -n $cmd > $DOTFILES/extras/ping.host
		killall -KILL $(pidof ping)
		rm -fr /tmp/ping_result /tmp/ping.log /tmp/ping.pid

		killall -$index $(pidof dwmblocks)

		exit 0
		;;
esac

SB=1 $DOTFILES/scripts/ping
