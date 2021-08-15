#!/bin/sh

while true; do
	echo -e "HTTP/1.1 200 OK\r\n $(cat ~/Docker/run.sh)" |
	netcat -lp 1500
	sleep 1
done
