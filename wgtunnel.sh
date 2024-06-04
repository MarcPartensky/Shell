#!/bin/sh
#
wstunnel client -L 'udp://0.0.0.0:42424:172.42.42.42:51820?timeout_sec=0' wss://wss.marcpartensky.com
