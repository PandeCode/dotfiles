#!/bin/env sh

case $BUTTON in
	1)
		cpuper="$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{printf 100 - $1""}')"
		topps=$(
			ps axch -o cmd,%cpu --sort=%cpu |
				awk '{ps[$1]+=1;cpu[$1]+=$2;} END {for (i in cpu){printf("%s %d %.2f%% \n", i,ps[i],cpu[i])}}' |
				sort -rnk3 |
				head |
				column -t
		)

		notify-send "CPU $cpuper" "$topps" -h int:value:"$cpuper"
		exit 0
		;;

	2)
		st -e htop
		exit 0
		;;

	3)
		topps=$(
			ps axch -o cmd,%cpu --sort=%cpu |
				awk '{ps[$1]+=1;cpu[$1]+=$2;} END {for (i in cpu){printf("%s %d %.2f%% \n", i,ps[i],cpu[i])}}' |
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
			"") exit 0 ;;
			"Humble (picom, xflux, nm-applet, clipit)")
				notify-send "killall -TERM picom xflux nm-applet clipit"
				killall -TERM picom xflux nm-applet clipit
				;;
			"Humble 2 (picom, xflux, nm-applet, clipit, chrome)")
				notify-send "killall -TERM picom xflux nm-applet clipit chrome"
				killall -TERM picom xflux nm-applet clipit chrome
				;;
			*)
				process=$(echo $cmd | sed 's/ .*//')
				notify-send "Killing $process"
				killall -TERM $process
				;;
		esac

		exit 0
		;;

esac

top -bn1 |
	grep 'Cpu(s)' |
	sed 's/.*, *\([0-9.]*\)%* id.*/\1/' |
	awk '{ per = 100 - $1 }
END {
if (per > 70) printf "^c#ff5555^";
else if(per > 50) printf "^c#f1fa8c^";
else printf "^c#8F93A2^"} 
END { printf per"%" "^c#8F93A2^" }'
