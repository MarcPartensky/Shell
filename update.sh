#!/bin/sh

sudo pacman -Sy
sudo powerpill -Su
paru -Su
hyprpm update
nvim --headless -c 'lua require("lazy").update()'
