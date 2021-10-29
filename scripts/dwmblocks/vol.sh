#!/bin/env sh

index=38 # 34 + 4

getVol() {
	amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $2 }'
}

isMuted() {
	pacmd list-sinks | awk '/muted/ { print $2 }'
}

volup() { amixer -q sset Master 5%+; }
voldown() { amixer -q sset Master 5%-; }
volmute() { amixer -q sset Master toggle; }
volnotiy() {
	NOTI_ID=$(notify-send.py "Volume" "$(getvol)/100" \
		--hint string:image-path:$ICON boolean:transient:true \
		int:has-percentage:$(getVol) \
		--replaces-process "volume-popup")
	retrun $NOTI_ID
}

case $BUTTON in
	1)
		volup
		kill -$index $(pidof dwmblocks)
		exit 0
		;;

	2)
		pavucontrol
		exit 0
		;;

	3)
		voldown
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
	if(volint > 90)
		printf(" ")
	else if(volint > 50)
		printf(" ")
	else if(volint > 30)
		printf(" ")
	else if(volint > 5)
		printf(" ")

	printf("%s%", volint);
}
'
