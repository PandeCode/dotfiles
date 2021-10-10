#!/bin/env sh

case $BUTTON in

	1) notify-send CPU "$(
		ps axch -o cmd,%cpu |
			awk '{arr[$1]+=$2; count[$1]+=1}; END {for (i in arr) {if(count[i] > 1) printf "("count[i]")";printf i ; print arr[i] }}' |
			sort -rnk2 |
			head |
			column -t
	)" ;;

	2) notify-send "CPU" ;;
	3) notify-send "CPU" ;;
esac
