#!/bin/env sh

index=39 # 34+5

case $BUTTON in
	1)
		notify-send "BAT" "$(acpi)"
		killall -$index $(pidof dwmblocks)
		exit 0
		;;

	2)
		st -e htop
		killall -$index $(pidof dwmblocks)
		exit 0
		;;

	3)
		killall -$index $(pidof dwmblocks)
		cmd="$(
			cat << EOF | xmenu
Light UP	light -S 100
Light HALF	light -S 50
Light DOWN	light -S 1
Extreme Save	light -S 1; killall -9 chrome picom xflux nm-applet clipit
EOF
			exit 0
		)"
		$cmd
		notify-send "$cmd"

		exit 0
		;;
esac

cat /sys/class/power_supply/ACAD/online /sys/class/power_supply/BAT1/capacity |
	tr '\n' ' ' |
	awk '{
		if($1) printf(" ");
		else {
			if($2>90)      printf("█");
			else if($2>80) printf("▇");
			else if($2>70) printf("▆");
			else if($2>60) printf("▅");
			else if($2>50) printf("▄");
			else if($2>40) printf("▃");
			else if($2>30) printf("▂");
			else 		   printf("▁");
		} 

		if($2>80)      printf ("^c#c3e88d^");
		else if($2>50) printf ("^c#ffcb6b^");
		else if($2>20) printf ("^c#f07178^");
		else           printf ("^c#ff5370^");

		print ($2 "%^c#8F93A2^")
}'



