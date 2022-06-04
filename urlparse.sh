#!/bin/bash

# extract the protocol
proto="$(echo $1 | grep :// | sed -e's,^\(.*://\).*,\1,g')"
echo "proto: $proto"

# remove the protocol -- updated
url=$(echo $1 | sed -e s,$proto,,g)
echo "url: $url"

# extract the user (if any)
user="$(echo $url | grep @ | cut -d@ -f1)"
echo "user: $user"

# extract the host and port -- updated
hostport=$(echo $url | sed -e s,$user@,,g | cut -d/ -f1)

# by request host without port
host="$(echo $hostport | sed -e 's,:.*,,g')"
echo "host: $host"

# by request - try to extract the port
port="$(echo $hostport | sed -e 's,^.*:,:,g' -e 's,.*:\([0-9]*\).*,\1,g' -e 's,[^0-9],,g')"
echo "port: $port"

# extract the path (if any)
path="$(echo $url | grep / | cut -d/ -f2-)"

echo "path: $path"
