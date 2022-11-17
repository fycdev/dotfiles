# Development Environment Setup (Culture Amp)

Quick setup guide for my personal development environment setup on M*-based Macs.

## Overview
Development environment consists of:
- `VScode` (text editor)
- `Warp` (terminal emulator)
- `vim`, `zsh`, `git`, `asdf`, `yarn` (CLI tools)

## Desktop tools
### VS Code
Download and install [VS Code](https://code.visualstudio.com/).

Login with Github.

Fix press and hold in VSCode with Vim.
```shell
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
```

### Warp
Download and install [Warp](https://warp.dev).

## Dotfiles
All dotfiles are located in the dotfiles repository and once cloned, the files are symlinked. Thus we can keep track of dotfile changes in one location.

### Clone repository
From the root directory:
```shell
mkdir ~/dev
cd ~/dev
git clone https://github.com/fycdev/dotfiles
```

### Configure `git`
In the dotfiles directory:
```shell
ln -sv $PWD/gitconfigglobal ~
ln -sv $PWD/gitignoreglobal ~
git config --global --unset include.path '.gitconfigglobal'
git config --global --add include.path ~/.gitconfigglobal
git config --global --unset core.excludesFile '.gitignoreglobal'
git config --global --add core.excludesFile ~/.gitignoreglobal
git config --global user.name "INSERT NAME"
git config --global user.email "INSERT EMAIL"
```

Make sure to update the local `user.email` for the dotfiles repository if different to global.
```shell
git config user.email "INSERT GITHUB EMAIL"
```

### Symlink `vim`, `zsh`, `ruby`, `postgres`
In the dotfiles directory:
```shell
ln -sv $PWD/.vimrc ~
ln -sv $PWD/.zshrc ~
ln -sv $PWD/.gemrc ~
ln -sv $PWD/.defaultgems ~
ln -sv $PWD/.rspec ~
ln -sv $PWD/.psqlrc ~
```

## Homebrew
Pretty much an essential OSX package manager and necessary for setting the rest of the development environment.
### Install Homebrew
Installation script
```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```
Refer to [brew.sh](brew.sh) for more information and help.

### Install CLI tools
```shell
brew install vim zsh git asdf yarn
```

### Install the Victor Mono font
I use the [Victor Mono](https://rubjo.github.io/victor-mono/) font for my terminal and editor. Although narrow, I find it to be quite readable. Plus it has support for programming ligatures which is nice to have.
```shell
brew tap homebrew/cask-fonts
brew cask install font-victor-mono
```
_Note: May need to restart the OS in order for the OS to register the fonts._

## ASDF
### Install asdf plugins
```shell
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
```

## Change default login shell
Since `brew`'s version of `zsh` is a non-standard shell, we can add it to `/etc/shells` to make it "standard". Refer to `man chsh` for more information.
```shell
echo "/opt/homebrew/bin/zsh" | sudo tee -a /etc/shells
```
Change the login shell
```shell
sudo chsh -s /opt/homebrew/bin/zsh
```
_Note: need to restart in order to take effect. After restarting delete `.zsh_history` and `.zsh_sessions/` from root directory._


