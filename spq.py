#!/usr/bin/env python
import os
import spotipy

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


def get_playlist_ids(username: str, playlist_id: str):
    """Get tracks ids using the playlist id and username"""
    r = sp.user_playlist_tracks(username, playlist_id)
    t = r["items"]
    ids = []
    while r["next"]:
        r = sp.next(r)
        t.extend(r["items"])
    for s in t:
        ids.append(s["track"]["id"])
    return ids


def tracks(user_id, playlist_id):
    """List all tracks"""
    track_ids = get_playlist_ids(user_id, playlist_id)
    for track_id in track_ids:
        track = sp.track(track_id)
        print(track["name"], "-", track["artists"][0]["name"])


my_id: str = sp.me()["id"]
my_playlist: str = track["context"]["uri"]
tracks(my_id, my_playlist)
