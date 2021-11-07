#!/bin/env sh

playerctl $1

notify-send -p -r $(cat /tmp/medianotifyid) "$1" "$(
	playerctl  metadata --format '{{status}}_{{playerName}}_{{position}}_{{volume}}_{{album}}_{{artist}}_{{title}}'
)" > /tmp/medianotifyid
