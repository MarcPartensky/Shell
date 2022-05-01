#!/usr/bin/env python
"""Monitor the wallpapers
"""

import os
import random
import argparse
from typing import List

PATH = os.path.expandvars("$WALLPAPERS_PATH")
CURRENT = os.path.expandvars("$HOME/.fehbg")


def list_wallpapers() -> List[str]:
    """List all wallpapers"""
    files = os.listdir(PATH)
    wallpapers = []
    for file in files:
        if file.endswith(".jpg"):
            wallpapers.append(file)
    return wallpapers


def clean_wallpapers(wallpapers) -> None:
    """Clean wallpapers names"""
    for i, wallpaper in enumerate(wallpapers):
        oldpath = os.path.join(PATH, wallpaper)
        newpath = os.path.join(PATH, f"{i}.jpg")
        os.rename(oldpath, newpath)


def add_wallpapers(wallpapers: List[str]) -> None:
    """Add some wallpapers"""
    n = len(list_wallpapers())
    for wallpaper in wallpapers:
        n += 1
        path = os.path.join(PATH, f"{n}.jpg")
        os.replace(wallpaper, path)


def get_current_wallpaper():
    """Get currently displayed wallpaper"""
    with open(CURRENT, "r", encoding="utf-8") as f:
        text = f.read()
    cmd = text.split("\n")[1]
    wallpaper = cmd.split("'")[1]
    return wallpaper


def remove_current_wallpaper() -> None:
    """Remove the curently displayed wallpaper"""
    os.remove(get_current_wallpaper())


def next_wallpaper():
    """Display the next random wallpaper"""
    n = len(list_wallpapers())
    i = random.randint(1, n)
    wallpaper = os.path.join(PATH, f"{i}.jpg")
    with open("/tmp/wpp", "w", encoding="utf-8") as f:
        f.write(wallpaper)
    cmd = f"feh --bg-scale {wallpaper}"
    os.system(cmd)
    return wallpaper


parser = argparse.ArgumentParser(prog=__doc__)
parser.add_argument("-n", "--next", action="store_true", help="next wallpaper")
parser.add_argument("-l", "--list", action="store_true", help="list wallpapers")
parser.add_argument(
    "-c", "--current", action="store_true", help="print current wallpaper"
)
parser.add_argument("-r", "--rm", action="store_true", help="remove current wallpaper")
parser.add_argument(
    "-a",
    "--add",
    type=str,
    nargs="*",
    default=[],
    help="Add wallpapers",
    metavar="wallpapers",
)

if __name__ == "__main__":
    wallpapers = list_wallpapers()
    clean_wallpapers(wallpapers)

    args = parser.parse_args()

    if args.list:
        print("\n".join(list_wallpapers()))
    elif args.current:
        print(get_current_wallpaper())
    elif args.rm:
        remove_current_wallpaper()
        wallpapers = list_wallpapers()
        clean_wallpapers(wallpapers)
    elif args.next:
        print(next_wallpaper())
    elif args.add:
        add_wallpapers(args.wallpapers)
        wallpapers = list_wallpapers()
        clean_wallpapers(wallpapers)
    else:
        parser.print_help()
