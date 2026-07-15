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

  # Branch names: with -a/-d, the branches of live twork tmux sessions — global,
  # so it works from any cwd, not just inside the repo. Otherwise all local
  # branches. Sessions tag themselves with @twork_branch (see bin/twork).
  local -a branches
  if (( ${words[(I)-d]} || ${words[(I)-a]} )); then
    branches=(${(f)"$(tmux list-sessions -F '#{@twork_branch}' 2>/dev/null)"})
    branches=(${branches:#})  # drop sessions without the tag
  else
    branches=(${(f)"$(git for-each-ref --format='%(refname:short)' refs/heads 2>/dev/null)"})
  fi

  _arguments -s \
    $flags \
    '*:branch:( $branches )'
}

compdef _twork twork
