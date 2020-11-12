# Development Environment Setup

Quick setup guide for my personal development environment setup on OSX.

## Homebrew
Pretty much an essential OSX package manager and necessary for setting the rest of the development environment.
### Install Homebrew
```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

### Install Additional Useful Taps
```shell
brew tap homebrew/cask-fonts
brew tap homebrew/cask-versions
```
`homebrew/cask-fonts` provides fonts to be installed and `homebrew/cask-versions` provides different versions of applications to be installed.

Refer to [brew.sh](brew.sh) for more information and help.

## Fonts
I use the [Victor Mono](https://rubjo.github.io/victor-mono/) font for my terminal and editor. Although narrow, I find it to be quite readable. Plus it has support for programming ligatures which is nice to have.

### Install the Victor Mono font
```shell
brew cask install font-victor-mono
```
_Note: May need to restart the OS in order for the OS to register the fonts._

## Tools 
The main tools I am currently using are:
* `alacritty` - terminal emulator
* `zsh` - terminal shell
* `tmux` - terminal multiplexer
* `vim` - CLI editor (though I use VSCode with the vim extension for main code editing)
* `git` - version control
* `n` - node version manager (useful as a frontend developer)
* `yarn` - alternative node package manager (still use `npm` depending on project)

### Install the CLI tools
```shell
brew install zsh tmux vim git n yarn
```
### Install the desktop tools
```shell
brew cask install alacritty visual-studio-code
```
You can also install additional programs such as various browsers and/or slack.
i.e `firefox-developer-edition google-chrome slack`

## Configuring Tools
Now that we have installed all the tools, it is time to configure them. This is where this repo comes in.

### Create a `~/dev` folder
This will house dotfiles and projects.
```shell
mkdir ~/dev
```

### Install dotfiles
Here we clone the dotfiles repository, make the install script executable, then execute the script. The script will symlink the dotfiles to the `~/` directory and include relevant paths to `git` (this is to ensure we can keep the `[user]` section separate from the repository and thus need to be manually configured after this step). 
```shell
cd ~/dev
git clone ...
cd dotfiles
chmod +x install.sh
./install.sh
```

### Add global git user
```shell
git config --global user.name = "INSERT NAME"
git config --global user.email = "INSERT EMAIL"
```

### Set permissions for `n`
This is to prevent all the permission denied lines when working with different `node` versions.
```shell
sudo chown -R $(whoami) /usr/local/n /usr/local/bin /usr/local/lib /usr/local/include /usr/local/share
```

This does change the owner permissions to yourself which may not be ideal (for me I am the only user of my machine so it won't make much difference). May change it in future. Refer [here](https://github.com/tj/n#installation) on installing `n`.

### Change the default login shell
Since `brew`'s version of `zsh` is a non-standard shell, we can add it to `/etc/shells` to make it "standard". Refer to `man chsh` for more information.
```shell
echo "/usr/local/bin/zsh" | sudo tee -a /etc/shells
```
Change the login shell
```shell
sudo chsh -s /usr/local/bin/zsh
```
_Note: need to restart in order to take effect_
