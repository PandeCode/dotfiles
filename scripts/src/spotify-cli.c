#include <stdio.h>
#include <stdlib.h>
#include <string.h>

inline static void printHelp() {
	printf("\033[1m\033[4mspotify-cli:"
	       "\n\tplay\n\tpause\n\tprev\n\tnext\n\ttoggle\033[0m\n");
}

int main(int argc, const char** argv) {
	if(argc < 2) {
		perror("At least one arg\n");
		printHelp();
		return 1;
	}

	const char baseCommand[] =
	    "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify "
	    "/org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.";

	if(strcmp(argv[1], "help") == 0)
		printHelp();

	else if(strcmp(argv[1], "play") == 0) {
		system("dbus-send --print-reply "
		       "--dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 "
		       "org.mpris.MediaPlayer2.Player.Play\n");
	} else if(strcmp(argv[1], "pause") == 0) {
		system("dbus-send --print-reply "
		       "--dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 "
		       "org.mpris.MediaPlayer2.Player.Pause");
	} else if(strcmp(argv[1], "prev") == 0) {
		system("dbus-send --print-reply "
		       "--dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 "
		       "org.mpris.MediaPlayer2.Player.Previous");
	} else if(strcmp(argv[1], "next") == 0) {
		system("dbus-send --print-reply "
		       "--dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 "
		       "org.mpris.MediaPlayer2.Player.Next");
	} else if(strcmp(argv[1], "toggle") == 0) {
		system("dbus-send --print-reply "
		       "--dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 "
		       "org.mpris.MediaPlayer2.Player.PlayPause");
	}

	return 0;
}
