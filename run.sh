#!/usr/bin/env sh

CONTAINER_TOOL=podman
hash podman 2>/dev/null || { CONTAINER_TOOL=docker; }

$CONTAINER_TOOL run -it --volume=./:/workbench/box-dir:Z nvim-box
