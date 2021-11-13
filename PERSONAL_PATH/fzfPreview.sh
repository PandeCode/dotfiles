#!/bin/sh

(
	[[ -f $1 ]] &&
		(
			bat --style=numbers --color=always $1 ||
				cat $1
		)
) ||
	(
		[[ -d $1 ]] &&
			(
				tree -C $1 |
					less
			)
	) ||
	echo $1 2> /dev/null | head -200
