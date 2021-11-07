check() {
	if ! command -v $1 &> /dev/null; then
		echo "'$1' could not be found. Install $2"
		notify-send "Error" "'$1' could not be found. Install $2"
		exit 1
	fi
}
