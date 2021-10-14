#!/bin/env sh

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

wirelessStrength(){
	echo $(awk '/^\s*w/ { print "📶", int($3 * 100 / 70) "% " }' /proc/net/wireless)
}

case $BUTTON in
	1) notify-send "Ping" "$(echo  "$(iwgetid)\n$(netTraf)\n$(wirelessStrength)")" ;;
	2) notify-send "Ping" "$BUTTON" ;;
	3) notify-send "Ping" "$BUTTON" ;;
esac
