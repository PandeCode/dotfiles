#!/bin/bash

xmonadConfigFile=~/.config/xmonad/xmonad.hs
xmonadConfig="$(cat $xmonadConfigFile)"

TOP_LEFT=╭     # ┌
TOP_RIGHT=╮    # ┐
BOTTOM_LEFT=╰  # └
BOTTOM_RIGHT=╯ # ┘
MID_HORIZONTAL=─
MID_VERTICAL=│

startString='-- SHOWKEYS START'
stopString='-- SHOWKEYS END'

# Regex to find '"M-x a"' in '("M-x a",  function) -- Comment'
bindingRegex='\(\s*"\K.*?(?="\s*,)'

# Regex to find 'Comment' in '("M-x ",  function) -- Comment'
commentRegex='\)\s*-- \s*\K.*'

declare -a bindings=()
declare -a comments=()
isReading=false

function getData() {
	while read line; do
		if [ "$line" == "$startString" ]; then
			# echo "Found start string"
			isReading=true
			echo '+──────────────────────────────`───────────────────────────────────────────────────────────+'
			echo '│ Binding ` Comment`'
			echo '+──────────────────────────────`───────────────────────────────────────────────────────────+`'
		elif [ "$line" == "$stopString" ]; then
			# echo "Found stop string"
			echo '+──────────────────────────────`───────────────────────────────────────────────────────────+'
			isReading=false
		elif $isReading; then
			# echo $line
			binding="$(grep -Po "$bindingRegex" <<< "$line")"
			bindings+=($binding)

			comment="$(grep -Po "$commentRegex" <<< "$line")"
			comments+=($comment)

			if ! [ -z "$binding" ]; then
				echo "│ '$binding' \` $comment \`"
			fi
		fi
	done < $xmonadConfigFile
}

getData | column -t -o '|' -s '`'
