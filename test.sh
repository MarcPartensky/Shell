#!/bin/sh

if [ $(uname) == "Linux" ]; then
	echo linux
elif [ $(uname) == "Darwin" ]; then
	echo 'not linux'
else
	echo 'nothing'
fi
