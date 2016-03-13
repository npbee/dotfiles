# Dotfiles

## Install

### Homebrew

```bash
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

### iTerm2

https://www.iterm2.com/

### ZSH

**Install**:
```bash
$ brew install zsh
```

**Change the shell**:
```bash
$ chsh -s $(which zsh)
```

**Install oh my zsh**
```bash
$ sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

### RCM

Rcm is used for managing.  We keep everything in ~/.dotfiles and then run `rcup` to distribute each folder as a dot file

```bash
$ brew install rcm
```

```bash
$ git clone git@github.com:npbee/dotfiles.git ~/.dotfiles
```

```bash
$ rcup
```

### FZF

Fzf needs a install step:

```bash
$ ./oh-my-zsh/custom/plugins/fzf/install.sh
```

### Neovim

We need to install neovim with Python3:

```bash
$ brew install python3
$ pip3 install neovim
```

**Link Vimrc**:
```bash
mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
ln -s ~/.vim $XDG_CONFIG_HOME/nvim
ln -s ~/.vimrc $XDG_CONFIG_HOME/nvim/init.vim
```

**Install Plugins**:

In VIM, run `:PlugInstall`
