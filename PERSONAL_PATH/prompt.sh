case "$1" in
	"window")
		rofi -show window -show-icons
	;;
	"run"|"raise")
		rofi -combi-modi window#drun -show combi -modi combi -show-icons
	;;
	"window_go")
		rofi -  
		;;
	"window_bring")
		rofi -  
		;;
	"help")
		notify-send "Prompt.sh" "
/ ==> help
w ==> window
r ==> run
n ==> notes
o ==> org
d ==> scripts_dir
l ==> layout
m ==> man
t ==> terminal
u ==> unicode
x ==> hypr
g ==> window_go
b ==> window_bring
"
		;;
	"notes")
		rofi -  
		;;
	"org")
		rofi -  
		;;
	"scripts_dir")
		rofi -  
		;;
	"layout")
		rofi -  
		;;
	"man")
		rofi -  
		;;
	"terminal")
		rofi -  
		;;
	"unicode")
		rofi -  
		;;
	"hypr")
rofi		 -  
		;;


	*)
		notify-send "Prompt.sh" "invalid '$1'"
	;;
esac

