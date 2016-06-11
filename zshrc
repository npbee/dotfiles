export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="pure"

plugins=(git zsh-syntax-highlighting fzf)

export CLICOLOR=1
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TERM=xterm-256color
export NVIM_TUI_ENABLE_TRUE_COLOR=1
export NVIM_TUI_ENABLE_CURSOR_SHAPE=1
export EDITOR=nvim

export PATH="$HOME/.bin:/usr/local/bin:$PATH"

source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag --path-to-agignore=~/.agignore -g ""'

[ -f ~/.zsh.local ] && source ~/.zsh.local

export NVM_DIR="/Users/nickball/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
