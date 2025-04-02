#!/bin/bash

yt-dlp -ciw -o '%(title)s.%(ext)s' -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' \
    --progress --audio-quality 0 --embed-thumbnail --embed-metadata --embed-subs --embed-chapters \
    --embed-info-json --rm-cache-dir --no-keep-fragments --sponsorblock-mark all --sponsorblock-remove all \
    --retry-sleep 10 --retries 1000 --file-access-retries 1000 --extractor-retries 1000 "$@"

file=$(yt-dlp --print filename -o '%(title)s.%(ext)s' "$@" | tail -n 1)
echo $file
[ -z "$file" ] && exit 1

out="${file%.*}.m4b"

duration=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$file")
[ -z "$duration" ] && { echo "Error: Cannot determine duration."; exit 1; }

ffmpeg -i "$file" -vn -c:a aac -b:a 128k -map_metadata 0 -map_chapters 0 "$out" \
    -progress pipe:1 -nostats 2>/dev/null | while IFS='=' read -r key value; do
    if [ "$key" = "out_time_ms" ]; then
        progress=$(awk -v t="$value" -v d="$duration" 'BEGIN {printf "%.0f", (t/1000000/d)*100}')
        echo -ne "\rProgress: $progress%"
    elif [ "$key" = "progress" ] && [ "$value" = "end" ]; then
        echo -ne "\rProgress: 100%"
    fi
done

echo -e "\nDone: $out"
rm -f "$file"
