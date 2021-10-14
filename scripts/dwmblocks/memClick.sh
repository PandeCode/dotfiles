#!/bin/env sh

LC_ALL=en_US.UTF-8
case $BUTTON in

		
	1) notify-send "$(
		free -m |
			awk '/^Mem/ {per=$3/$2*100;total=$2;used=$3;free=$4}; END {printf("Memory: %dMB - %dMB = %dMB; %f%%",used,total,free,per) }'
	)" "$(
		ps axch -o cmd,%mem,rss |
			awk '{ps[$1]+=1;mem[$1]+=$2;rss[$1]+=$3} END {for (i in mem){printf("%s %d %.2f%% %'"'"'dKB\n", i,ps[i],mem[i],rss[i])}}' |
			sort -rnk3 |
			head |
			column -t
	)" -h int:value:$(free -m | awk '/Mem/ {print int($3/$2*100)}') ;;

	2) notify-send "Mem" "$BUTTON" ;;
	3) notify-send "Mem" "$BUTTON" ;;
esac

#ps axch -o cmd,rss |
#awk '{arr[$1]+=$2; count[$1]+=1}; END {for (i in arr) {if(count[i] > 1) printf "("count[i]")";printf i; print arr[i] }}' |
#sort -rnk2 |
#head |
#column -t
