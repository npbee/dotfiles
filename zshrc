
# Pure Prompt Setup
fpath=( ~/.zsh/prompt $fpath )
autoload -U promptinit && promptinit
prompt pure

# load our own completion functions
fpath=(~/.zsh/completion $fpath)
autoload -U compinit
compinit

 #load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

# enable colored output from ls, etc
export CLICOLOR=1
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TERM=xterm-256color
export NVIM_TUI_ENABLE_TRUE_COLOR=1
export NVIM_TUI_ENABLE_CURSOR_SHAPE=1
export EDITOR=nvim

# awesome cd movements from zshkit
setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars
DIRSTACKSIZE=5

# history settings
setopt hist_ignore_all_dups inc_append_history
HISTFILE=~/.zhistory
HISTSIZE=4096
SAVEHIST=4096

# Enable extended globbing
setopt extendedglob

# ensure dotfiles bin directory is loaded first
export PATH="$HOME/.bin:/usr/local/bin:$PATH"

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# Virtual ENV
export WORKON_HOME=~/.virtualenv
source /usr/local/bin/virtualenvwrapper.sh

# Base16 Shell
BASE16_SCHEME="eighties"
BASE16_SHELL="$HOME/.config/base16-shell/base16-$BASE16_SCHEME.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# Adjust Path
PATH=/usr/local/bin:$PATH
export PATH

# Syntax Highlighting
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# FASD
if command -v fasd >/dev/null 2>&1; then
    eval "$(fasd --init zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install posix-alias)"
fi

PATH="/Applications/MAMP/bin/php/php5.5.18/bin:$PATH"

export ELM_HOME="/usr/local/lib/node_modules/elm/share"
export NVM_DIR="/Users/nickball/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag --path-to-agignore=~/.agignore -g ""'

# Google Cloud Stuff
# The next line updates PATH for the Google Cloud SDK.
source '/Users/nickball/google-cloud-sdk/path.zsh.inc'
export PATH=$PATH:$HOME/google-cloud-sdk/bin
export PYTHONPATH=$PYTHONPATH:$HOME/google-cloud-sdk/platform/google_appengine
