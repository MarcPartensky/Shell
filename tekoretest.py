#!/usr/bin/env python

import os
import tekore as tk

client_id = os.environ["TEKORE_CLIENT_ID"]
client_secret = os.environ["TEKORE_CLIENT_SECRET"]
print(client_id, client_secret)

app_token = tk.request_client_token(client_id, client_secret)
spotify = tk.Spotify(app_token)

import asyncio


async def now_playing():
    return await spotify.playback_currently_playing()


np = asyncio.run(now_playing())
