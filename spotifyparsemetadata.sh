#!/bin/sh

METADATA=/tmp/spotifymetadata
LYRICS=/tmp/spotifylyrics

# LYRICS_LIMIT=10000

# Get current player
player=$(playerctl -l | grep 'spot' | head -1 2>/dev/null) || {
    echo '{"text":"","tooltip":""}'
    exit 0
}

# Get metadata
playerctl -p "$player" metadata > "$METADATA" 2>/dev/null || {
    echo '{"text":"","tooltip":""}'
    exit 0
}

# Clean metadata fields function
clean_field() {
    echo "$1" | 
    tr -s ' ' |
    awk '{$1=$2=""; print $0}' |
    sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' -e 's/"/\\"/g'
}

# Process metadata
title=$(clean_field "$(grep xesam:title "$METADATA")")
artist=$(clean_field "$(grep xesam:artist "$METADATA")")
album=$(clean_field "$(grep xesam:album "$METADATA")")

# Create unique song identifier hash
current_hash=$(echo "$title:$artist:$album" | md5sum | cut -d' ' -f1)

# Check cache
if [ -f "$LYRICS" ]; then
    cached_hash=$(head -1 "$LYRICS")
    cached_lyrics=$(tail -n +2 "$LYRICS")
    
    if [ "$current_hash" = "$cached_hash" ]; then
        lyrics="$cached_lyrics"
        use_cache=true
    fi
fi

# Fetch new lyrics only if needed
if [ -z "$use_cache" ]; then
    lyrics=$(http --body "https://api.lyrics.ovh/v1/$artist/$title" 2>/dev/null | 
        jq -r '.lyrics? // "Lyrics not available"' 2>/dev/null)

    echo $lyrics > /tmp/raw

    lyrics=$(echo $lyrics | awk '
            BEGIN { RS="^$"; ORS=""; }
            {
                # Convert CRLF to LF
                gsub(/\r\n/, "\n")
                # Replace 2 newlines with 1
                # gsub(/\n\n/, "\n")
                # Replace 3+ newlines with 2
                gsub(/\n{3,}/, "\n\n")
                print
            }
            ' > /tmp/test)
    # 
    # Store in cache
    echo "$current_hash" > "$LYRICS"
    echo "$lyrics" >> "$LYRICS"
fi

# sed -i'' -e 's/\r//g' "$LYRICS"
# sed -i'' -e 's/\n//g' "$LYRICS"
# sed -i'' -e '
#     N;
#     /^\n$/d;
#     P;
#     D
# ' $LYRICS

# sed -i'' -e '/^$/{N;/^\n$/d;}' $LYRICS

# sed -i'' -e '
#     s/\\r\\n/\\n/g;
#     s/\\n\\n/\\n/g
#     s/\\n\\n\\n/\\n\\n/g
# ' $LYRICS
# n edited lyrics
# lyrics=`cat $LYRICS`

# Format output with JQ to prevent JSON errors
text="$title | $artist | $album"
tooltip="$text\n\n$lyrics"

 
output="{\"text\":\""$text"\",\"tooltip\":\""$tooltip"\"}"
# n $output
echo $output
