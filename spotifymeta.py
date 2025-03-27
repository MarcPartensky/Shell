#!/usr/bin/env python3

import os
import hashlib
import json
import re
import subprocess
from pathlib import Path

METADATA_FILE = Path("/tmp/spotifymetadata")
LYRICS_FILE = Path("/tmp/spotifylyrics")
LYRICS_LIMIT=10000


def get_player():
    try:
        players = subprocess.check_output(["playerctl", "-l"], text=True)
        spotify_player = [p for p in players.splitlines() if "spot" in p][0]
        return spotify_player
    except (subprocess.CalledProcessError, IndexError):
        return None


def clean_field(raw_field):
    # Remove prefix and clean whitespace
    cleaned = " ".join(raw_field.split()[2:]).strip()
    # Remove surrounding quotes and escape internal ones
    return cleaned.replace('"', "").replace("'", "")


def get_metadata(player):
    try:
        metadata = subprocess.check_output(
            ["playerctl", "-p", player, "metadata"], text=True
        )
        with open(METADATA_FILE, "w") as f:
            f.write(metadata)
        return metadata
    except subprocess.CalledProcessError:
        return None


def process_lyrics(raw_lyrics):
    # Convert Windows line endings
    processed = raw_lyrics.replace("\r\n", "\n")
    # Reduce double newlines to single
    processed = re.sub(r"\n\n", "\n", processed)
    # Reduce 3+ newlines to 2
    processed = re.sub(r"\n{3,}", "\n\n", processed)
    return processed.strip()


def main():
    # Check if Spotify is running
    player = get_player()
    if not player:
        print(json.dumps({"text": "", "tooltip": ""}))
        return

    # Get metadata
    metadata = get_metadata(player)
    if not metadata:
        print(json.dumps({"text": "", "tooltip": ""}))
        return

    # Extract fields
    fields = {"title": "", "artist": "", "album": ""}

    with open(METADATA_FILE) as f:
        for line in f:
            line = line.strip()
            if "xesam:title" in line:
                fields["title"] = clean_field(line)
            elif "xesam:artist" in line:
                fields["artist"] = clean_field(line)
            elif "xesam:album" in line:
                fields["album"] = clean_field(line)

    # Create content hash
    content_hash = hashlib.md5(
        f"{fields['title']}:{fields['artist']}:{fields['album']}".encode()
    ).hexdigest()

    lyrics = ""
    use_cache = False

    # Check cache
    if LYRICS_FILE.exists():
        with open(LYRICS_FILE) as f:
            cached_hash = f.readline().strip()
            if cached_hash == content_hash:
                lyrics = f.read()
                use_cache = True

    # Fetch new lyrics if needed
    if not use_cache:
        try:
            from requests import get

            artist_escaped = fields["artist"].replace(" ", "%20")
            title_escaped = fields["title"].replace(" ", "%20")
            response = get(
                f"https://api.lyrics.ovh/v1/{artist_escaped}/{title_escaped}", timeout=5
            )
            raw_lyrics = response.json().get("lyrics", "Lyrics not available")
        except Exception as e:
            raw_lyrics = "Lyrics not available"

        lyrics = process_lyrics(raw_lyrics)

        # Update cache
        with open(LYRICS_FILE, "w") as f:
            f.write(f"{content_hash}\n{lyrics}")

    # Prepare output
    text = f"{fields['title']} | {fields['artist']} | {fields['album']}"
    tooltip = f"{text}\n\n{lyrics}"

    print(json.dumps({"text": text, "tooltip": tooltip}))


if __name__ == "__main__":
    main()
