#!/bin/sh

ping 8.8.8.8 |
	perl -pe \
		's/.*time=(\d+).*/{"text": "\1", "class":"custom-media", "alt":"ping"}/; s/PING.*\n//;'
