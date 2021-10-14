#!/bin/env sh

case $BUTTON in
	1)
		cpuper="$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{printf 100 - $1""}')"
		notify-send "CPU $cpuper" "$(
			ps axch -o cmd,%cpu |
				awk '{ps[$1]+=1;cpu[$1]+=$2;} END {for (i in cpu){printf("%s %d %.2f%% \n", i,ps[i],cpu[i])}}' |
				sort -rnk3 |
				head |
				column -t
		)" -h int:value:"$cpuper"
		;;

	2) notify-send "CPU" ;;
	3) notify-send "CPU" ;;
esac
