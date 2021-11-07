#!/bin/env sh

index=38 # 34 + 4

getVol() {
	amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $2 }'
}

isMuted() {
	pacmd list-sinks | awk '/muted/ { print $2 }'
}

volNotify() {
        notify-send 'Vol' -h int:value:$(pamixer --get-volume)
}

volMute() {
        pactl set-sink-mute @DEFAULT_SINK@ toggle
}

volUp() {
        pactl set-sink-volume @DEFAULT_SINK@ +10%
}

volDown() {
        pactl set-sink-volume @DEFAULT_SINK@ -10%
}

case $BUTTON in
	1)
		volUp
		kill -$index $(pidof dwmblocks)
		exit 0
		;;

	2)
		killall -$index $(pidof dwmblocks)
		pavucontrol
		exit 0
		;;

	3)
		volDown
		kill -$index $(pidof dwmblocks)
		exit 0
		;;
esac

echo $(getVol) $(isMuted) | awk '{
	volint = int( $1 );
	mute = $2;
}
END {
	if(mute == "yes")
		printf(" ")
	else if(volint > 80)
		printf(" ")
	else if(volint > 50)
		printf(" ")
	else if(volint > 30)
		printf(" ")
	else if(volint > 10)
		printf(" ")

	printf("%s%", volint);
}
'
