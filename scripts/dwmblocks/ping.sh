#!/bin/env sh

index=35 # 34+1
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

case $BUTTON in
	1)
		killall -$index $(pidof dwmblocks)
		notify-send "Ping" "$(echo "$(iwgetid)\n$(netTraf)\n$(wirelessStrength)")"
		exit 0;
		;;
	2)
		killall -$index $(pidof dwmblocks)
		xdg-open "http://$(ip route | grep default | grep -Eo '[0-9]+.[0-9]+.[0-9]+.[0-9]+')"
		exit 0;
		;;
	3)
		killall -$index $(pidof dwmblocks)
		notify-send "Ping" "$BUTTON" 
		exit 0;
		;;
esac

SB=1 ~/dotfiles/scripts/ping
