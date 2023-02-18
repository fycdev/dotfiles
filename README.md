# Development Environment Setup

Quick setup guide for my personal development environment setup on M*-based Macs.


## Overview
Base development environment consists of:
  - `alacritty` (terminal)
  - `fish` (shell)
  - `tmux` (terminal multiplexer)
  - `neovim` (editor)
  - `git` (source control)
  - `asdf` (version manager)


## Homebrew
Pretty much an essential OSX package manager and necessary for setting the rest of the development environment.

### Install Homebrew
Installation script
```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```
Refer to [brew.sh](brew.sh) for more information and help.

### Install brew packages
```shell
brew tap homebrew/cask-fonts
brew install alacritty fish git nvim tmux asdf font-anonymice-nerd-font
```
_Note: May need to restart the OS in order for the OS to register the fonts._


## Dotfiles
All dotfiles are located in the dotfiles repository and once cloned, the files are symlinked. Thus we can keep track of dotfile changes in one location.

### Create directories and install dotfiles
From `$HOME` (`~/`) directory:
```shell
mkdir dev .config
cd ~/dev
git clone https://github.com/fycdev/dotfiles
cd dotfiles
chmod +x setup.sh
./setup.sh
```

### Configure `git`
Create a filter to remove user name and email when staging.
```shell
echo '**/git/config filter=cleangitconfig' > .git/info/attributes
git config --local filter.cleangitconfig.clean "sed -E '/(name)|(email)|\[user\]/d'"
git config --global user.email "INSERT GITHUB EMAIL"
git config --global user.name "INSERT NAME"
```
_Note: Every time the dotfiles repository is pulled or checked out, name and email must be set again._


## Change default login shell
Since `fish` is a non-standard shell, we can add it to `/etc/shells` to make it "standard". Refer to `man chsh` for more information.
```shell
echo "/opt/homebrew/bin/fish" | sudo tee -a /etc/shells
sudo chsh -s /opt/homebrew/bin/fish
```
_Note: need to restart in order to take effect._


## asdf
### Install asdf plugins
```shell
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin add python https://github.com/asdf-community/asdf-python
asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf plugin add rust https://github.com/asdf-community/asdf-rust.git
```

