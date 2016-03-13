# Dotfiles

## Install

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

Rcm is used for managing.  We keep everything in ~/.dotfiles and then run `cup` to distribute each folder as a dot file

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
