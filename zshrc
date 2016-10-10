fpath=("$HOME/.zsh/functions" $fpath)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.zsh.local ] && source ~/.zsh.local
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
[[ -f ~/.aliases ]] && source ~/.aliases

# Syntax highlighting
source $HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Default ZSH completion
autoload -Uz compinit && compinit

# Completion
completion_files=($HOME/.zsh/completion/*.zsh)
for file in $completion_files
do
    source $file
done

# Prompt
autoload -U promptinit && promptinit
prompt pure

# Hub
eval "$(hub alias -s)"

export CLICOLOR=1
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TERM=xterm-256color-italic
export NVIM_TUI_ENABLE_TRUE_COLOR=1
export NVIM_TUI_ENABLE_CURSOR_SHAPE=1
export EDITOR=nvim
export PATH="$HOME/.bin:/usr/local/bin:$PATH"
export FZF_DEFAULT_COMMAND='ag --path-to-ignore=~/.agignore -g ""'


export NVM_DIR="/Users/nickball/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
