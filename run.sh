#!/bin/sh

trap 'echo "exiting ..."; exit' TERM INT

ip=`ifconfig | awk '/ *inet addr:/ { match($0, "[0-9\.]+"); ip=substr($0, RSTART, RLENGTH); if (ip != "127.0.0.1") { print ip } }'`

while true
do
	echo "waiting ..."
	printf "`date '+%H:%M:%S'`    %-16s    %s\n" $ip $HOSTNAME | nc -q 0 -l 3333 > /dev/null &
	wait $!
	echo "new request served."
done
