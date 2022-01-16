#!/usr/bin/env python
import os
import spotipy
from rich import print

client_id = os.environ["SPOTIPY_CLIENT_ID"]
client_secret = os.environ["SPOTIPY_CLIENT_SECRET"]


redirect_uri = "http://localhost:8888/callback/"
scope = "user-read-currently-playing"


auth_manager = spotipy.oauth2.SpotifyOAuth(
    client_id=client_id,
    client_secret=client_secret,
    redirect_uri=redirect_uri,
    scope=scope,
)

sp = spotipy.Spotify(auth_manager=auth_manager)
track: dict = sp.current_user_playing_track()
del track["item"]["available_markets"]
del track["item"]["album"]["available_markets"]

print(track)
