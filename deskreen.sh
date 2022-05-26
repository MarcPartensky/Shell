#!/bin/sh

git -C $PROGRAMS_PATH clone git@github.com:marcpartensky/deskreen
npm start --prefix $PROGRAMS_PATH/deskreen
