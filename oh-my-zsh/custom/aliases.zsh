# Unix
alias tlf="tail -f"
alias ln='ln -v'
alias mkdir='mkdir -p'
alias ...='../..'
alias l='ls'
alias ll='ls -al'
alias lh='ls -Alh'
alias -g G='| grep'
alias -g M='| less'
alias -g L='| wc -l'
alias -g ONE="| awk '{ print \$1}'"
alias e="$EDITOR"
alias v="$VISUAL"

# git
alias gci="git pull --rebase && rake && git push"
alias stpp=subtree push --prefix

# dotfiles
alias dotfiles="cd ~/.dotfiles"

# home folder
alias home="cd ~"

# projects
alias projects="cd ~/Projects"

# Show hidden files
alias showhidden="defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app"

# Hide hidden files
alias hidehidden="defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app"

# source zshrc
alias sourcezsh="source ~/.zshrc"

# ia writer
alias ia="open $1 -a /Applications/iA\ Writer.app"

# Include custom aliases
[[ -f ~/.aliases.local ]] && source ~/.aliases.local

