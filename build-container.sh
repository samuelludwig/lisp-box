#!/usr/bin/env bash

CONTAINER_TOOL=podman

hash podman 2>/dev/null || { CONTAINER_TOOL=docker; }

$CONTAINER_TOOL build -t nvim-box -f Containerfile .
