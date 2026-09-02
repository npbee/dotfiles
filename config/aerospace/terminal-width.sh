#!/usr/bin/env bash
# Set the terminal's width to a fraction of the screen; its tiling sibling
# (the browser) absorbs the remainder. Targets by bundle id rather than the
# focused window, so the same key works from either side of the split.
set -euo pipefail

fraction=${1:?usage: terminal-width.sh <fraction, e.g. 0.75>}

id=$(aerospace list-windows --all --json --format '%{window-id}%{app-bundle-id}' \
  | jq -r 'first(.[] | select(."app-bundle-id"
      | . == "net.kovidgoyal.kitty" or . == "com.mitchellh.ghostty")
    | ."window-id") // empty')
[ -n "$id" ] || exit 0

# AeroSpace sizes in points, so use the desktop bounds, not the Retina resolution.
screen=$(osascript -e 'tell application "Finder" to get bounds of window of desktop' | awk -F', ' '{print $3}')
aerospace resize --window-id "$id" width "$(printf '%.0f' "$(echo "$screen * $fraction" | bc -l)")"
