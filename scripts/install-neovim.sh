#!/usr/bin/env bash

wget 'https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage'

chmod u+x nvim.appimage

mkdir -p /usr/local/bin
mv nvim.appimage /usr/local/bin/nvim
