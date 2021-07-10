#!/bin/bash

randomport() {
	comm -23 <(seq 49152 65535 | sort) <(ss -htan | awk '{print $4}' | cut -d':' -f2 | sort -u) | shuf | head -n 1
}

randomport
# ports=$(seq 49152 65535 | sort)
# a=$(ss -htan | awk '{print $4}' | cut -d':' -f2 | sort -u)
# echo $a
# echo $ports
# | shuf | head -n $1
# r=$(comm -23 <($ports) <($a))
# echo $r

# | shuf | head -n $1
