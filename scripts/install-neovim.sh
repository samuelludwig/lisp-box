#!/usr/bin/env bash

wget 'https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage'

mkdir -p /usr/local/bin

## Doesn't work in a Container without FUSE :^(
#mv nvim.appimage /usr/local/bin/nvim

chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
ln -s /squashfs-root/usr/bin/nvim /usr/local/bin/nvim
