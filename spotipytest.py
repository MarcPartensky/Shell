#!/usr/bin/env python
import os
import sys
import spotipy
from spotipy.oauth2 import SpotifyClientCredentials

client_id = os.environ["SPOTIPY_CLIENT_ID"]
client_secret = os.environ["SPOTIPY_CLIENT_SECRET"]
print(client_id, client_secret)


client_credentials_manager = SpotifyClientCredentials(
    client_id=client_id,
    client_secret=client_secret,
)
sp = spotipy.Spotify(client_credentials_manager=client_credentials_manager)

playlists = sp.user_playlists("spotify")
while playlists:
    for i, playlist in enumerate(playlists["items"]):
        print(
            "%4d %s %s"
            % (i + 1 + playlists["offset"], playlist["uri"], playlist["name"])
        )
    if playlists["next"]:
        playlists = sp.next(playlists)
    else:
        playlists = None
