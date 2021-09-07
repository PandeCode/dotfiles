#!/usr/bin/env bash

style="$($HOME/.config/rofi/applets/applets/style.sh)"

dir="$HOME/.config/rofi/applets/applets/configs/$style"
rofi_command="rofi -theme $dir/mpd.rasi"

play_pause=""
active=""
urgent=""
stop=""
next=""
previous=""

# Variable passed to rofi
options="$previous\n$play_pause\n$stop\n$next\n$tog_repeat\n$tog_random"

current=$(playerctl metadata artist title)
if [[ -z "$current" ]]; then current="-" fi

# Spawn the mpd menu with the "Play / Pause" entry selected by default
chosen="$(echo -e "$options" | $rofi_command -p "  $current" -dmenu $active $urgent -selected-row 1)"
case $chosen in
$previous)
    playerctl --player=spotify previous && notify-send -u low -t 1800 " $(playerctl metadata artist title)"
    ;;
$play_pause)
    playerctl --player=spotify play-pause && notify-send -u low -t 1800 " $(playerctl metadata artist title)"
    ;;
$stop)
    playerctl --player=spotify stop && notify-send -u low -t 1800 " $(playerctl metadata artist title)"
    ;;
$next)
    playerctl --player=spotify next && notify-send -u low -t 1800 " $(playerctl metadata artist title)"
    ;;
$tog_repeat)
    playerctl --player=spotify loop "Track"
    ;;
$tog_random)
    playerctl --player=spotify shuffle "Toggle"
    ;;
esac
