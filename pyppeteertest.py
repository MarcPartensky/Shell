#!/usr/bin/env python

import asyncio
import trio
from pyppeteer import launch


async def main():
    print("main")
    browser = await launch()
    page = await browser.newPage()
    await page.goto("https://marcpartensky.com")
    await page.screenshot({"path": "/tmp/website.png"})
    await browser.close()


asyncio.get_event_loop().run_until_complete(main())
