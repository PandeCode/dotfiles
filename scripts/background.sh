#!/bin/env bash

DISPLAY=:0

watch -n 900 "feh --randomize --bg-fill /home/shawn/Pictures/Wallpapers/*" &>/dev/null &

disown
