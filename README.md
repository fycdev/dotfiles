# Development Environment Setup

Quick setup guide for my personal development environment setup on Apple Silicon Macs.


## Overview
Base development environment consists of:
  - `kitty` (terminal)
  - `fish` (shell)
  - `tmux` (terminal multiplexer)
  - `neovim` (editor)
  - `git` (source control)
  - `asdf` (version manager)

The goal is to keep setup simple, lean, and generic.


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
brew install kitty fish git nvim tmux asdf font-anonymous-pro font-symbols-only-nerd-font
```
_Note: May need to restart the OS in order for the OS to register the fonts._


## Dotfiles
All dotfiles are located in the dotfiles repository. Once the repository is cloned, `setup.sh` will symlink them to their corresponding directories. Thus we can keep track of dotfile changes in one location.

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
Optionally, create a git clean/smudge filter to replace user name and email, and organisation name and email, to keep dotfiles generic when pushed. Currently, this is a manual process.
```shell
echo '**/git/config filter=config' >> .git/info/attributes
echo '**/git/hooks/pre-commit filter=precommit' >> .git/info/attributes
git config --local filter.config.clean "sed -E -e 's/name = .*/name = REPLACE_NAME/' -e 's/email = .*/email = REPLACE_EMAIL/'"
git config --local filter.config.smudge "sed -E -e 's/REPLACE_NAME/{INSERT GITHUB NAME}/' -e 's/REPLACE_EMAIL/{INSERT GITHUB EMAIL}/'"
git config --local filter.precommit.clean "sed -E -e 's/ORG_NAME=.*/ORG_NAME=\"REPLACE_ORG_NAME\"/' -e 's/ORG_EMAIL=.*/ORG_EMAIL=\"REPLACE_ORG_EMAIL\"/'"
git config --local filter.precommit.smudge "sed -E -e 's/=\"REPLACE_ORG_NAME\"/=\"{INSERT ORG NAME}\"/' -e 's/=\"REPLACE_ORG_EMAIL\"/=\"{INSERT ORG EMAIL}\"/'"
```
```shell
git config --global user.email "INSERT GITHUB EMAIL"
git config --global user.name "INSERT GITHUB NAME"
```


## Change default login shell
Since `fish` is a non-standard shell, we can add it to `/etc/shells` to make it "standard". Refer to `man chsh` for more information.
```shell
echo "/opt/homebrew/bin/fish" | sudo tee -a /etc/shells
sudo chsh -s /opt/homebrew/bin/fish
```
_Note: need to restart in order to take effect. Development environment should be ready afterwards._


## asdf
### Install asdf plugins
```shell
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin add python https://github.com/asdf-community/asdf-python
asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf plugin add rust https://github.com/asdf-community/asdf-rust.git
```

