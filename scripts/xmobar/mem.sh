#!/bin/sh


LC_ALL=en_US.UTF-8
case $1 in
	1)
		notify-send "$(
			free -m |
				awk '
/^Mem/ {
	per=$3/$2*100;
	total=$2;
	used=$3;
	free=$4
}; END {
	printf("Memory: %dMB - %dMB = %dMB; %f%%",used,total,free,per) 
}'
		)" "$(
			ps axch -o cmd,%mem,rss |
				awk '{
	ps[$1]+=1;
	mem[$1]+=$2;
	rss[$1]+=$3
} END {
	for (i in mem) {
		printf("%s %d %.2f%% %'"'"'dKB\n", i,ps[i],mem[i],rss[i])
	}
}' |
				sort -rnk3 |
				head |
				column -t
		)" -h int:value:$(free -m | awk '/Mem/ {print int($3/$2*100)}') -t 2000

		exit 0
		;;

	2)
		st -e htop
		exit 0
		;;

	3)
		topps=$(
			ps axch -o cmd,%mem,rss |
				awk '{
	ps[$1]+=1;
	mem[$1]+=$2;
	rss[$1]+=$3
} END {
	for (i in mem) {
		printf("%s %d %.2f%% %'"'"'dKB\n", i,ps[i],mem[i],rss[i])
	}
}' |
				sort -rnk3 |
				head |
				column -t |
				sed 's/^/\t/;'
		)
		cmd="$(
			cat << EOF | xmenu
Kill
$topps
Humble (picom, xflux, nm-applet, clipit)
Humble 2 (picom, xflux, nm-applet, clipit, chrome)
EOF
		)"

		case $cmd in
			"Humble (picom, xflux, nm-applet, clipit)")
				notify-send "killall -TERM picom xflux nm-applet clipit" -t 2000
				killall -TERM picom xflux nm-applet clipit
				;;
			"Humble 2 (picom, xflux, nm-applet, clipit, chrome)")
				notify-send "killall -TERM picom xflux nm-applet clipit chrome" -t 2000
				killall -TERM picom xflux nm-applet clipit chrome 
				;;
			"") exit 0 ;;
			*)
				process=$(echo $cmd | sed 's/ .*//')
				notify-send "Killing $process" -t 2000
				killall -TERM $process
				;;
		esac

		exit 0
		;;

esac

free -m |
	awk '/^Mem/ {per=int($3/$2*100)}; 
END {
	if (per > 70) printf "^c#ff5555^";
	else if(per > 50) printf "^c#f1fa8c^";
	else printf "^c#8F93A2^"} 
END {
	printf per"%" "^c#9F93A2^" 
}
'
