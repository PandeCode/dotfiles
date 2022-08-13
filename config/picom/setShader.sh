#!/bin/sh

shaderFilename="$1"

if [ -f "$shaderFilename" ]; then
	killall -9 picom
	picom --dbus -b --glx-fshader-win "$(cat $shaderFilename)" &&
		notify-send "Picom" "Shader loaded: $shaderFilename" ||
		notify-send "Picom Error" "Shader failed to load: $shaderFilename" -u critical
else
	notify-send "Picom Error" "Shader file not found: $shaderFilename" -u critical
	exit 1
fi
