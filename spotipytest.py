#!/usr/bin/env python
import os
import spotipy
from spotipy.oauth2 import SpotifyClientCredentials, SpotifyOAuth

# if ".cache" in os.listdir():
#     os.remove(".cache")

client_id = os.environ["SPOTIPY_CLIENT_ID"]
client_secret = os.environ["SPOTIPY_CLIENT_SECRET"]
print(client_id, client_secret)


# client_credentials_manager = SpotifyClientCredentials(
#     client_id=client_id,
#     client_secret=client_secret,
# )

redirect_uri = "http://localhost:8888/callback/"


auth_manager = SpotifyOAuth(
    client_id=client_id,
    client_secret=client_secret,
    redirect_uri=redirect_uri,
    scope="user-library-read",
    open_browser=True,
)

# token = auth_manager.get_access_token(check_cache=False)
# print(token)
# auth_manager.refresh_access_token(token)

# print(auth_manager.state)

sp = spotipy.Spotify(auth_manager)

# print(auth_manager.get_cached_token())

# print(sp.current_user_playing_track())
# print(sp.user_playlists(sp.user))


# playlists = sp.user_playlists("spotify")
# while playlists:
#    for i, playlist in enumerate(playlists["items"]):
#        print(
#            "%4d %s %s"
#            % (i + 1 + playlists["offset"], playlist["uri"], playlist["name"])
#        )
#        if playlists["next"]:
#            playlists = sp.next(playlists)
#        else:
#            playlists = None

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

# results = sp.current_user_saved_tracks(limit=5)
# for idx, item in enumerate(results["items"]):
#     track = item["track"]
#     print(idx, track["artists"][0]["name"], " – ", track["name"])

urn = 'spotify:artist:3jOstUTkEu2JkjvRdBA5Gu'
sp = spotipy.Spotify()

artist = sp.artist(urn)
print(artist)

user = sp.user('plamere')
print(user)

