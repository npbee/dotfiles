
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

# makes color constants available
#autoload -U colors
#colors

# enable colored output from ls, etc
export CLICOLOR=1

# history settings
setopt hist_ignore_all_dups inc_append_history
HISTFILE=~/.zhistory
HISTSIZE=4096
SAVEHIST=4096

# awesome cd movements from zshkit
setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars
DIRSTACKSIZE=5

# Enable extended globbing
setopt extendedglob

# handy keybindings
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^R" history-incremental-search-backward
bindkey "^P" history-search-backward

# use vim as the visual editor
export VISUAL=vim
export EDITOR=$VISUAL

# ensure dotfiles bin directory is loaded first
export PATH="$HOME/.bin:/usr/local/bin:$PATH"

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# Google Cloud Stuff
export PATH=$PATH:$HOME/google-cloud-sdk/bin
export PYTHONPATH=$PYTHONPATH:$HOME/google-cloud-sdk/platform/google_appengine

# Virtual ENV
export WORKON_HOME=~/.virtualenv
source /usr/local/bin/virtualenvwrapper.sh

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/base16-default.dark.sh"
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
