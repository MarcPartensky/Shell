#!/bin/bash

help() {
    echo "Usage: $(basename "$0") <file.mp4>"
    exit 1
}

[ "$#" -ne 1 ] && help
[ ! -f "$1" ] && echo "Error: File not found." && exit 1
command -v ffmpeg >/dev/null || { echo "Error: ffmpeg not installed."; exit 1; }

out="${1%.*}.m4b"
ffmpeg -i "$1" -vn -c:a aac -b:a 128k -map_metadata 0 -map_chapters 0 "$out"

echo "Done: $out"
