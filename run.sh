#!/usr/bin/env sh

podman run -it --volume=$(pwd)/nvim-conf:/root/.config/nvim:Z lisp-box
