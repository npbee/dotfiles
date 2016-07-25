# Dotfiles

## Install

I've got an attempt at a one-script set up at

```bash
$ ./init/boostrap
```

This will install homebrew and various packages, zsh stuff, etc.  If that goes wrong...

### Homebrew

```bash
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

### ZSH

**Install**:
```bash
$ brew install zsh
```

**Change the shell**:
```bash
$ chsh -s $(which zsh)
```

### RCM

Rcm is used for managing.  We keep everything in ~/.dotfiles and then run `rcup` to distribute each folder as a dot file

```bash
$ brew tap thoughtbot/formulae
$ brew install rcm
```

```bash
$ git clone git@github.com:npbee/dotfiles.git ~/.dotfiles
```

```bash
$ cd ~/.dotfiles && rcup -x readme.md
```

### Neovim

We need to install neovim with Python3:

```bash
$ brew install neovim/neovim/neovim
$ brew install python3
$ pip3 install neovim
```

**Install Plugins**:

In VIM, run `:PlugInstall`

### iTerm2

**Install**:
https://www.iterm2.com/

**Install patched font**
- Double-click on font in `./fonts/`

**Load iTerm preferences**

`./iTerm`

### ATOM

Atom configuration is included here, but to install the necessary packages, run

```bash
apm stars --install
```
