#!/bin/bash

source_port=$(curl -s https://marcpartensky.com/api/port)
proto="$(echo $1 | grep :// | sed -e's,^\(.*://\).*,\1,g')"
echo "proto: $proto"
if [ -z $proto ]; then
	url=$1
else
	url=$(echo $1 | sed -e s,$proto,,g)
fi
user="$(echo $url | grep @ | cut -d@ -f1)"
echo "user: $user"
hostport=$(echo $url | sed -e s,$user@,,g | cut -d/ -f1)
host="$(echo $hostport | sed -e 's,:.*,,g')"
echo "host: $host"
port="$(echo $hostport | sed -e 's,^.*:,:,g' -e 's,.*:\([0-9]*\).*,\1,g' -e 's,[^0-9],,g')"
echo "port: $port"
path="$(echo $url | grep / | cut -d/ -f2-)"

echo "${proto}marcpartensky.com:$source_port"
if [ -f ~/.ssh/expose ]; then
	ssh -i ~/.ssh/expose -R $source_port:$host:$port expose@marcpartensky.com -N -p 7022
else
	ssh -R $source_port:$host:$port expose@marcpartensky.com -N -p 7022
fi

