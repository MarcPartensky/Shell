#!/bin/sh

while true; do systemctl --user restart wpaperd; sleep 3; done & 2> /tmp/test.pid
cat /tmp/test.pid
