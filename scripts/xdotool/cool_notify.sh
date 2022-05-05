#/bin/sh

notify-send.py $@

./slidein.sh "notification"

time=3
# if -t in agrgs, use that as time

args=("$@")
for ((i = 0; i < $#; i++)); do
	if [ "${args[$i]}" = "-t" ]; then
		time=$((${args[i + 1]} - 2))
	fi
done
echo $time

sleep $time
./slideout.sh "notification"
