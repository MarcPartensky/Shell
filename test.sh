#!/bin/sh

# if [ $(uname) == "Linux" ]; then
# 	echo linux
# elif [ $(uname) == "Darwin" ]; then
# 	echo 'not linux'
# else
# 	echo 'nothing'
# fi

a=1
b=2
echo ${c:=$((a+b))}

if ((a!=b)); then
	echo $c
fi
