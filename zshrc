source "$HOME/.zsh/antigen.zsh"

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle agkozak/zsh-z
antigen bundle joshskidmore/zsh-fzf-history-search
antigen bundle git

antigen apply

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

# Default ZSH completion
autoload -Uz compinit && compinit

# Vim Mode ftw
bindkey -v
bindkey -M vicmd '?' history-incremental-search-backward

# Faster vi mode switching
export KEYTIMEOUT=1
source $HOME/.zsh/vi.zsh

# FZF stuff
source $HOME/.zsh/fzf.zsh

# Completion
source $HOME/.zsh/completion/npm.zsh
# zstyle ':completion:*:*:git:*' script $HOME/.zsh/completion/git.zsh
completion_files=($HOME/.zsh/completion/*.zsh)
for file in $completion_files
do
    source $file
done

# Prompt
autoload -U promptinit && promptinit
prompt pure


# Auto suggestions
bindkey '^\n' autosuggest-execute

# Hub
eval "$(hub alias -s)"

export CLICOLOR=1
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TERM=xterm-kitty
export NVIM_TUI_ENABLE_TRUE_COLOR=1
export EDITOR=nvim
export PATH="$HOME/.bin:/usr/local/bin:$HOME/go/bin:$PATH"
export FZF_DEFAULT_COMMAND='fd --type file'
# export FZF_PREVIEW_COMMAND="bat --style=header,grid --wrap never --color always {} || cat {} || tree -C {}"
# export FZF_DEFAULT_OPTS="--preview-window 'right:55%:hidden' --inline-info"
export BAT_THEME="1337"
export NVIM_LOG_FILE=~/.local/share/nvim/log
export RIPGREP_CONFIG_PATH=~/.config/ripgreprc

# The next line updates PATH for Netlify's Git Credential Helper.
if [ -f '/Users/npbee/.netlify/helper/path.zsh.inc' ]; then source '/Users/npbee/.netlify/helper/path.zsh.inc'; fi

if type fnm &> /dev/null; then
    eval "$(fnm env)"
fi
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

eval "$(direnv hook zsh)"


# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

# pnpm
export PNPM_HOME="/Users/nickball/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.zsh.local ] && source ~/.zsh.local
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
[[ -f ~/.aliases ]] && source ~/.aliases


