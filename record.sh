#!/bin/sh

filepath=~/Videos/`date +%Y-%m-%d_%H:%M:%S`.mp4
if command -v wf-recorder >& /dev/null; then
    wf-recorder --file=$filepath # --audio # record external audio
fi
