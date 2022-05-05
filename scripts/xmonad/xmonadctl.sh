#!/bin/sh

case "$1" in

	"view  0") ~/.config/xmonad/xmonadctl/xmonadctl 1  ;;
	"shift 0") ~/.config/xmonad/xmonadctl/xmonadctl 2  ;;
	"view  1") ~/.config/xmonad/xmonadctl/xmonadctl 3  ;;
	"shift 1") ~/.config/xmonad/xmonadctl/xmonadctl 4  ;;
	"view  2") ~/.config/xmonad/xmonadctl/xmonadctl 5  ;;
	"shift 2") ~/.config/xmonad/xmonadctl/xmonadctl 6  ;;
	"view  3") ~/.config/xmonad/xmonadctl/xmonadctl 7  ;;
	"shift 3") ~/.config/xmonad/xmonadctl/xmonadctl 8  ;;
	"view  4") ~/.config/xmonad/xmonadctl/xmonadctl 9  ;;
	"shift 4") ~/.config/xmonad/xmonadctl/xmonadctl 10 ;;
	"view  5") ~/.config/xmonad/xmonadctl/xmonadctl 11 ;;
	"shift 5") ~/.config/xmonad/xmonadctl/xmonadctl 12 ;;
	"view  6") ~/.config/xmonad/xmonadctl/xmonadctl 13 ;;
	"shift 6") ~/.config/xmonad/xmonadctl/xmonadctl 14 ;;
	"view  7") ~/.config/xmonad/xmonadctl/xmonadctl 15 ;;
	"shift 7") ~/.config/xmonad/xmonadctl/xmonadctl 16 ;;
	"view  8") ~/.config/xmonad/xmonadctl/xmonadctl 17 ;;
	"shift 8") ~/.config/xmonad/xmonadctl/xmonadctl 18 ;;

	screen0)              ~/.config/xmonad/xmonadctl/xmonadctl 19 ;;
	screen-to-0)          ~/.config/xmonad/xmonadctl/xmonadctl 20 ;;
	screen1)              ~/.config/xmonad/xmonadctl/xmonadctl 21 ;;
	screen-to-1)          ~/.config/xmonad/xmonadctl/xmonadctl 22 ;;
	shrink)               ~/.config/xmonad/xmonadctl/xmonadctl 23 ;;
	expand)               ~/.config/xmonad/xmonadctl/xmonadctl 24 ;;
	next-layout)          ~/.config/xmonad/xmonadctl/xmonadctl 25 ;;
	default-layout)       ~/.config/xmonad/xmonadctl/xmonadctl 26 ;;
	restart-wm)           ~/.config/xmonad/xmonadctl/xmonadctl 27 ;;
	restart-wm-no-resume) ~/.config/xmonad/xmonadctl/xmonadctl 28 ;;
	xterm)                ~/.config/xmonad/xmonadctl/xmonadctl 29 ;;
	run)                  ~/.config/xmonad/xmonadctl/xmonadctl 30 ;;
	kill)                 ~/.config/xmonad/xmonadctl/xmonadctl 31 ;;
	refresh)              ~/.config/xmonad/xmonadctl/xmonadctl 32 ;;
	focus-up)             ~/.config/xmonad/xmonadctl/xmonadctl 33 ;;
	focus-down)           ~/.config/xmonad/xmonadctl/xmonadctl 34 ;;
	swap-up)              ~/.config/xmonad/xmonadctl/xmonadctl 35 ;;
	swap-down)            ~/.config/xmonad/xmonadctl/xmonadctl 36 ;;
	swap-master)          ~/.config/xmonad/xmonadctl/xmonadctl 37 ;;
	sink)                 ~/.config/xmonad/xmonadctl/xmonadctl 38 ;;
	quit-wm)              ~/.config/xmonad/xmonadctl/xmonadctl 39 ;;

	*)
		echo -en $"\
1  - view  workspace 0
2  - shift workspace 0
3  - view  workspace 1
4  - shift workspace 1
5  - view  workspace 2
6  - shift workspace 2
7  - view  workspace 3
8  - shift workspace 3
9  - view  workspace 4
10 - shift workspace 4
11 - view  workspace 5
12 - shift workspace 5
13 - view  workspace 6
14 - shift workspace 6
15 - view  workspace 7
16 - shift workspace 7
17 - view  workspace 8
18 - shift workspace 8
19 - screen0
20 - screen-to-0
21 - screen1
22 - screen-to-1
23 - shrink
24 - expand
25 - next-layout
26 - default-layout
27 - restart-wm
28 - restart-wm-no-resume
29 - xterm
30 - run
31 - kill
32 - refresh
33 - focus-up
34 - focus-down
35 - swap-up
36 - swap-down
37 - swap-master
38 - sink
39 - quit-wm"
		;;
esac
