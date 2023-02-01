#!/bin/sh

getVol() {
	pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '\/\s+\K\d+%(?=\s+\/)' | head -n 1
}

isMuted() {
	pacmd list-sinks | awk '/muted/ { print $2 }'
}

volNotify() {
        notify-send 'Vol' -h int:value:$(pamixer --get-volume) -t 500
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

case $1 in
	1)
		notify-send "Vol" "$(getVol)" -t 500
		exit 0
		;;

	2)
		pavucontrol
		exit 0
		;;

	3)
		cmd="$(
		cat << EOF | xmenu
st -e pulsemixer
pavucontrol
EOF
		)"

		$cmd
		exit 0
		;;

	4)
		volUp

		exit 0
		;;

	5)
		volDown

		exit 0
		;;
esac

echo -n "<action=\`$DOTFILES/scripts/xmobar/vol.sh 1\` button=1><action=\`$DOTFILES/scripts/xmobar/vol.sh 2\` button=2><action=\`$DOTFILES/scripts/xmobar/vol.sh 3\` button=3><action=\`$DOTFILES/scripts/xmobar/vol.sh 4\` button=4><action=\`$DOTFILES/scripts/xmobar/vol.sh 5\` button=5>$(getVol) </action></action></action></action></action>"
