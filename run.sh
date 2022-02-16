#!/usr/bin/env sh

podman run -it --volume=$(pwd)/cosmic-nvimrc:/root/.config/nvim:Z --volume=./../:/workbench:Z lisp-box
