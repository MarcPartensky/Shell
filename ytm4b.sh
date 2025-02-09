#!/bin/bash

dlp() {
    yt-dlp -ciw -o '%(title)s.%(ext)s' -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' \
        --progress --audio-quality 0 --embed-thumbnail --embed-metadata --embed-subs --embed-chapters \
        --embed-info-json --rm-cache-dir --no-keep-fragments --sponsorblock-mark all --sponsorblock-remove all \
        --retry-sleep 10 --retries 1000 --file-access-retries 1000 --extractor-retries 1000 "$@"
}

convert_to_m4b() {
    for file in *.mp4; do
        [ -f "$file" ] || continue
        out="${file%.*}.m4b"
        ffmpeg -i "$file" -vn -c:a aac -b:a 128k -map_metadata 0 -map_chapters 0 "$out"
        rm -f "$file"
        echo "Converted: $out"
    done
}

dlp "$@"
convert_to_m4b
