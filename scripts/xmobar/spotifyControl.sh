#!/bin/sh

getAction() {
	if [ "$(dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'PlaybackStatus' | grep -Po '(?<=").*(?=")')" == "Playing" ]; then
		echo '<action=`playerctl pause`>'
	else
		echo '<action=`playerctl play`>'
	fi
}

echo -n "\
<action=\`playerctl previous\`>  </action>\
$(getAction)</action>\
<action=\`playerctl next\`>  </action>\
"
