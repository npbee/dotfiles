_twork() {
  local -a flags
  flags=(
    '-a[Attach to an existing worktree only]'
    '-c[Launch Claude (opus) in the new session]'
    '-d[Remove worktree and kill tmux session]'
    '-n[Skip dependency install on new worktree]'
    '-h[Show help]'
    '--help[Show help]'
  )

  # Branch names: with -a/-d, only branches that have a worktree under the
  # twork base dir; otherwise all local branches.
  local -a branches
  if (( ${words[(I)-d]} || ${words[(I)-a]} )); then
    local root base
    root="$(git rev-parse --show-toplevel 2>/dev/null)" || return
    base="$(dirname "$root")/${root:t}-worktrees/"
    # Strip the base prefix off each worktree path; keeps nested (foo/bar) names.
    branches=(${(f)"$(git worktree list --porcelain 2>/dev/null \
      | awk '/^worktree /{print substr($0,10)}')"})
    branches=(${(M)branches:#${base}*})
    branches=(${branches#${base}})
  else
    branches=(${(f)"$(git for-each-ref --format='%(refname:short)' refs/heads 2>/dev/null)"})
  fi

  _arguments -s \
    $flags \
    '*:branch:( $branches )'
}

compdef _twork twork
