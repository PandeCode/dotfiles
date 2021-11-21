#!/bin/bash

xmonadHsFilePath=~/dotfiles/config/xmonad/xmonad.hs

startOptions=("    --SHOWKEYS START", "   --SHOWKEYS START", "  --SHOWKEYS START", " --SHOWKEYS START", "--SHOWKEYS START", "	--SHOWKEYS START")
endOptions=("    --SHOWKEYS END", "   --SHOWKEYS END", "  --SHOWKEYS END", " --SHOWKEYS END", "--SHOWKEYS END", "	--SHOWKEYS END")

shouldRead=false

keys=()
actions=()
keyActions=()

# Desparation
longestKeyFile=/tmp/longestKeyFile
longestActionFile=/tmp/longestActionFile

function main() {

	while IFS= read -r line; do
		if $shouldRead; then
			if [ "$line" == " ]" ]; then
				shouldRead=false
				break
			elif [ "$line" == "" ] || [ "$line" == "--*" ] || [ "$line" == "    --*" ]; then
				continue
			fi

			tmp=$(echo $line | sed 's|  ||;s|--.*||')
			if [[ -n ${tmp// /} ]]; then
				key=$(echo $tmp | grep -Po '(?<=\(").*(?=",)')
				action=$(echo $tmp | grep -Po '(?<=,\s).*(?=\))')

				if (($((${#key})) > longestKey)); then
					longestKey=$((${#key}))
					echo $longestKey -n > $longestKeyFile
				fi
				if (($((${#action})) > longestAction)); then
					longestAction=$((${#action}))
					echo $longestAction -n > $longestActionFile
				fi

				keys+=("$key")
				actions+=("$action")
				keyActions+=("$key|$action")

			fi

		else

			if [ "$line" == "myKeybinds = [" ]; then shouldRead=true; fi
		fi
	done <<<"$(cat $xmonadHsFilePath)"

	for ka in "${keyActions[@]}"; do
		echo "|$ka|"
	done
}

main | awk -F'|' -v longestKey=$(cat $longestKeyFile) -v longestAction=$(cat $longestActionFile) 'function rn(s, n) {
	r="";
	for(i = 0; i < n; i++) {
		r = r s;
	}
	return r
}
BEGIN {
	print("|", rn("-", longestKey), "|", rn("-", longestAction), "|");
	print("|KEY|ACTION|");
	print("|", rn("-", longestKey), "|", rn("-", longestAction), "|");
}
{
	print $0  $1
}
END {
	print("|", rn("-", longestKey), "|", rn("-", longestAction), "|")
}' | sed 's/|/,|,/g' | column -s ',' -t
