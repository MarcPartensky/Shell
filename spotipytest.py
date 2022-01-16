#!/usr/bin/env python
import os
import sys
import spotipy
from spotipy.oauth2 import SpotifyClientCredentials, SpotifyOAuth

client_id = os.environ["SPOTIPY_CLIENT_ID"]
client_secret = os.environ["SPOTIPY_CLIENT_SECRET"]
print(client_id, client_secret)


client_credentials_manager = SpotifyClientCredentials(
    client_id=client_id,
    client_secret=client_secret,
)

redirect_uri = "http://localhost:8888/callback/"


sp = spotipy.Spotify(
    auth_manager=SpotifyOAuth(
        client_id=client_id,
        client_secret=client_secret,
        redirect_uri=redirect_uri,
        scope="user-library-read",
    )
)

# sp = spotipy.Spotify(client_credentials_manager=client_credentials_manager)

# playlists = sp.user_playlists("spotify")
# while playlists:
#     for i, playlist in enumerate(playlists["items"]):
#         print(
#             "%4d %s %s"
#             % (i + 1 + playlists["offset"], playlist["uri"], playlist["name"])
#         )
#     if playlists["next"]:
#         playlists = sp.next(playlists)
#     else:
#         playlists = None

results = sp.current_user_saved_tracks()
for idx, item in enumerate(results["items"]):
    track = item["track"]
    print(idx, track["artists"][0]["name"], " – ", track["name"])
