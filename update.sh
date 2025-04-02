#!/bin/sh

sudo pacman -Sy
sudo powerpill -Su
paru -Su
hyprpm update
firefoxpwa profile list | g ID | awk '{print $2}' | xargs -I {} firefoxpwa profile update {}
nvim --headless -c 'lua require("lazy").update()'
