#!/usr/bin/env sh

podman run -it --volume=$(pwd)/cosmic-nvimrc:/root/.config/nvim:Z --volume=./../:/root/workbench:Z lisp-box
