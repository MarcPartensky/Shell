#!/bin/sh

# comm -23 <(seq 49152 65535 | sort) <(ss -htan | awk '{print $4}' | cut -d':' -f2 | sort -u) | shuf | head -n $1
ports=$(seq 49152 65535 | sort)
a=$(ss -htan | awk '{print $4}' | cut -d':' -f2 | sort -u)
# | shuf | head -n $1
comm -23 <($ports) <($a) | shuf | head -n $1
