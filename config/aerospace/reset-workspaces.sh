#!/usr/bin/env bash
# Re-apply the on-window-detected rules from aerospace.toml to every open
# window. AeroSpace only runs those rules when a window is created, so this
# is the way to pull drifted windows back into place.
set -euo pipefail

config="$(dirname "$0")/aerospace.toml"

# One line per rule: "<app-id> <workspace|-> <layout|->"
rules=$(awk -v q="'" '
  function flush() {
    if (app != "") print app, (ws == "" ? "-" : ws), (layout == "" ? "-" : layout)
    app = ws = layout = ""
  }
  /^\[\[on-window-detected\]\]/ { flush(); next }
  /^[[:space:]]*if\.app-id/ {
    match($0, q "[^" q "]+" q); app = substr($0, RSTART + 1, RLENGTH - 2)
  }
  /^[[:space:]]*run/ {
    if (match($0, "move-node-to-workspace [^" q "]+")) ws = substr($0, RSTART + 23, RLENGTH - 23)
    if (match($0, "layout (floating|tiling)")) layout = substr($0, RSTART + 7, RLENGTH - 7)
  }
  END { flush() }
' "$config")

focused=$(aerospace list-workspaces --focused)
windows=$(aerospace list-windows --all --format '%{window-id} %{app-bundle-id}')

while read -r app ws layout; do
  for id in $(awk -v a="$app" '$2 == a { print $1 }' <<<"$windows"); do
    if [ "$layout" != - ]; then aerospace layout --window-id "$id" "$layout" || true; fi
    if [ "$ws" != - ]; then aerospace move-node-to-workspace --window-id "$id" "$ws" || true; fi
  done
done <<<"$rules"

aerospace workspace "$focused"
