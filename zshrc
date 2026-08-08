# Zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -d "$ZINIT_HOME" ]]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"
unalias zi 2>/dev/null

# Eager: zinit's turbo scheduler never fires for snippets, and this one is only
# ~7ms anyway.
zinit snippet OMZP::git

# Turbo: these load just after the first prompt instead of blocking it. Order
# matters — syntax highlighting wraps widgets, so it goes before
# autosuggestions, same as when they loaded eagerly.
zinit ice wait lucid
zinit light zsh-users/zsh-syntax-highlighting
# The ^\n binding lives here because its widget does not exist until the plugin
# is loaded.
zinit ice wait lucid atload"!_zsh_autosuggest_start; bindkey '^\n' autosuggest-execute"
zinit light zsh-users/zsh-autosuggestions

# Vars
export HISTSIZE='10000'
export SAVEHIST='100000'
export HISTFILE=$HOME/.zhistory

# Options

setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.
setopt APPEND_HISTORY            # append to history file
setopt HIST_NO_STORE             # Don't store history commands

# Path

fpath=("$HOME/.zsh/functions" $fpath)
fpath+=/opt/homebrew/share/zsh/site-functions

# Default ZSH completion; rebuild the dump at most once a day, else just load
# it. -C skips the fpath scan and security audit, which cost ~250ms with the
# plugin completion dirs on fpath.
autoload -Uz compinit
_zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
# The glob qualifier has to expand in an array assignment; [[ ]] does not do
# filename generation, so testing the pattern there always looks "fresh".
_zcompdump_fresh=( $_zcompdump(N.mh-24) )
if (( $#_zcompdump_fresh )); then
  compinit -C -d "$_zcompdump"
else
  compinit -i -d "$_zcompdump"
  # compinit skips the write when the dump is already current, so stamp it
  # ourselves; otherwise the mtime check above never goes cold.
  touch "$_zcompdump"
fi
# Byte-compile the dump so subsequent loads read the .zwc instead of parsing it.
if [[ ! -s "$_zcompdump.zwc" || "$_zcompdump" -nt "$_zcompdump.zwc" ]]; then
  zcompile -R -- "$_zcompdump"
fi
unset _zcompdump _zcompdump_fresh

# fzf-tab renders completion menus (incl. twork) in fzf. Must load after
# compinit and before any widget-wrapping plugins.
zinit light Aloxaf/fzf-tab

# Vim Mode ftw
bindkey -v
bindkey -M vicmd '?' history-incremental-search-backward

# Faster vi mode switching
export KEYTIMEOUT=1
source $HOME/.zsh/vi.zsh

# FZF stuff
source $HOME/.zsh/fzf.zsh

# Completion
for file in $HOME/.zsh/completion/*.zsh(N); do
    source $file
done
unset file

# Prompt
autoload -U promptinit && promptinit
prompt pure


# Hub
# eval "$(hub alias -s)"

export CLICOLOR=1
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
# export TERM=xterm-kitty
export EDITOR=nvim
export PATH="$HOME/.bin:/usr/local/bin:$HOME/go/bin:$PATH"
export FZF_DEFAULT_COMMAND='fd --type file'
# export FZF_PREVIEW_COMMAND="bat --style=header,grid --wrap never --color always {} || cat {} || tree -C {}"
# export FZF_DEFAULT_OPTS="--preview-window 'right:55%:hidden' --inline-info"
export BAT_THEME="1337"
export NVIM_LOG_FILE=~/.local/share/nvim/log
export RIPGREP_CONFIG_PATH=~/.config/ripgreprc
export LG_CONFIG_FILE="$HOME/.config/lazygit.yml"

function lg() {
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

    lazygit "$@"

    if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
            cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
            rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    fi
}

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

eval "$(zoxide init zsh)"
eval "$(atuin init zsh)"


# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

# pnpm
export PNPM_HOME="/Users/nickball/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.zsh.local ] && source ~/.zsh.local
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
[[ -f ~/.aliases ]] && source ~/.aliases

# After local sourcing so fnm's node shadows the homebrew node on PATH.
if type fnm &> /dev/null; then
    eval "$(fnm env --use-on-cd)"

    # Active node version for the right prompt. Resolve the multishell symlink
    # target rather than shelling out to `node -v`. Exposed via a global so the
    # vi-mode RPS1 (see zsh/vi.zsh) can compose it without clobbering.
    _pure_node_version() {
        local target=${FNM_MULTISHELL_PATH:A}/bin/node
        target=${target:A}
        if [[ $target == */node-versions/* ]]; then
            local v=${target#*/node-versions/}
            NODE_PROMPT_INFO="%F{green}⬢ ${v%%/*}%f"
        else
            NODE_PROMPT_INFO=''
        fi
    }
    autoload -Uz add-zsh-hook
    add-zsh-hook precmd _pure_node_version
fi

[[ "$TERM" == "xterm-kitty" ]] && alias ssh="TERM=xterm-256color ssh"
