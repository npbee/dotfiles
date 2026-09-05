#!/usr/bin/env python3
"""Rename worktree workspaces from Linear branch names.

Sidebar labels default to the branch slug, so `nick/lin-1234-fix-the-thing`
eats the width twice over: an owner prefix that is identical on every row, and
a title long enough to clip under the tree indent. Reduce it to `LIN-1234 fix
the thing`, capped to what the sidebar shows. The full branch stays visible
via the `branch` token.
"""

import json
import os
import re
import subprocess
import sys

# Sidebar is pinned at 44 columns; worktree children lose ~6 to the tree
# indent and ~2 to the state icon.
MAX_LABEL = 32

TICKET = re.compile(r"^([a-z]{2,6})-(\d+)-(.*)$", re.IGNORECASE)


def shorten(branch):
    """Return a display label, or None to leave herdr's default alone."""
    tail = branch.rsplit("/", 1)[-1]
    match = TICKET.match(tail)
    if not match:
        return None

    prefix, number, rest = match.groups()
    ticket = f"{prefix.upper()}-{number}"
    title = rest.replace("-", " ").strip()
    if not title:
        return ticket

    label = f"{ticket} {title}"
    if len(label) <= MAX_LABEL:
        return label
    # Trim on a word boundary so the label never ends mid-word.
    budget = MAX_LABEL - len(ticket) - 2
    clipped = title[:budget].rsplit(" ", 1)[0] if budget > 0 else ""
    return f"{ticket} {clipped}…".replace(" …", "…")


def main():
    raw = os.environ.get("HERDR_PLUGIN_EVENT_JSON")
    if not raw:
        return 0

    data = json.loads(raw).get("data", {})
    branch = data.get("worktree", {}).get("branch")
    workspace_id = data.get("workspace", {}).get("workspace_id")
    if not branch or not workspace_id:
        return 0

    label = shorten(branch)
    if not label:
        return 0

    subprocess.run(
        ["herdr", "workspace", "rename", workspace_id, label],
        check=False,
        stdout=subprocess.DEVNULL,
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())
