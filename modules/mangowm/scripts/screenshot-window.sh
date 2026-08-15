#!/usr/bin/env bash

set -euo pipefail
mkdir -p "$HOME/pictures/screenshots"
filepath="$HOME/pictures/screenshots/$(date +%Y%m%d%H%M%S).png"

# Noctalia's own screenshot service (screenshot-region/screenshot-fullscreen) covers area and monitor capture. This
# script only handles the focused window, which Noctalia has no dedicated mode for.
#
# https://github.com/noctalia-dev/noctalia/issues/3380
g=$(mmsg get focusing-client | jq -r '"\(.x),\(.y) \(.width)x\(.height)"')
[ -z "$g" ] && exit 1
grim -g "$g" "$filepath"
wl-copy < "$filepath"
