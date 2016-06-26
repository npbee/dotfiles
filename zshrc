fpath=("$HOME/.zsh/functions" $fpath)

export CLICOLOR=1
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TERM=xterm-256color
export NVIM_TUI_ENABLE_TRUE_COLOR=1
export NVIM_TUI_ENABLE_CURSOR_SHAPE=1
export EDITOR=nvim
export PATH="$HOME/.bin:/usr/local/bin:$PATH"

export FZF_DEFAULT_COMMAND='ag --path-to-agignore=~/.agignore -g ""'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.zsh.local ] && source ~/.zsh.local
[[ -f ~/.aliases ]] && source ~/.aliases
source $HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

autoload -U promptinit && promptinit
prompt pure
