#!/usr/bin/env sh

CONTAINER_TOOL=podman
hash podman 2>/dev/null || { CONTAINER_TOOL=docker; }

$CONTAINER_TOOL start neovim-testbench && $CONTAINER_TOOL attach neovim-testbench
