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
fpath+=$HOME/.zsh/plugins/pure

# Syntax highlighting
source $HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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
completion_files=($HOME/.zsh/completion/*.zsh)
for file in $completion_files
do
    source $file
done

# Prompt
autoload -U promptinit && promptinit
prompt pure

# Auto suggestions
source $HOME/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Z
source $HOME/.zsh/plugins/z/z.sh

# Hub
eval "$(hub alias -s)"

export CLICOLOR=1
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TERM=xterm-256color
export NVIM_TUI_ENABLE_TRUE_COLOR=1
export EDITOR=nvim
export PATH="$HOME/.bin:/usr/local/bin:$PATH"
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow'
export FZF_PREVIEW_COMMAND="bat --style=header,grid --wrap never --color always {} || cat {} || tree -C {}"
export FZF_DEFAULT_OPTS="--preview-window 'right:60%' --preview '$FZF_PREVIEW_COMMAND'"
export BAT_THEME="1337"
export NVIM_LOG_FILE=~/.local/share/nvim/log
export RIPGREP_CONFIG_PATH=~/.ripgreprc


# Special iTerm escape sequences for stylin'
# echo -e "\033]6;1;bg;red;brightness;50\a" && echo -e "\033]6;1;bg;green;brightness;50\a" && echo -e "\033]6;1;bg;blue;brightness;50\a" && clear

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.zsh.local ] && source ~/.zsh.local
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
[[ -f ~/.aliases ]] && source ~/.aliases


# The next line updates PATH for Netlify's Git Credential Helper.
if [ -f '/Users/npbee/.netlify/helper/path.zsh.inc' ]; then source '/Users/npbee/.netlify/helper/path.zsh.inc'; fi
