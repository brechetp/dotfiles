#!/usr/bin/env bash

# install xcode and other software from the app store
# everything neccessary first - command line tools
xcode-select --install

read -p "Press any key to continue... " -n1 -s

# install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor

# brew paths
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

# install some neccessary brew packages
brew install clipper
brew install fzf
brew install git
brew install tmux
brew install zsh
read -p "Press any key to continue... " -n1 -s
brew install python3
brew install neovim/neovim/neovim
read -p "Press any key to continue... " -n1 -s

# install all submodules
git submodule init
git submodule update
read -p "Press any key to continue... " -n1 -s

# link the dotfiles
mkdir ~/.config
ln -s ~/dotfiles/agignore ~/.agignore
ln -s ~/dotfiles/editorconfig ~/.editorconfig
ln -s ~/dotfiles/gemrc ~/.gemrc
ln -s ~/dotfiles/gitconfig ~/.gitconfig
ln -s ~/dotfiles/gitignore ~/.gitignore
ln -s ~/dotfiles/hammerspoon ~/.hammerspoon
ln -s ~/dotfiles/karabiner ~/.config/karabiner
ln -s ~/dotfiles/nvim ~/.config/nvim
ln -s ~/dotfiles/ruby-version ~/.ruby-version
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/zsh ~/.zsh
ln -s ~/dotfiles/zsh/zshrc ~/.zshrc
read -p "Press any key to continue... " -n1 -s

# install fzf
/usr/local/opt/fzf/install
read -p "Press any key to continue... " -n1 -s

# this is the minimal software and fonts used
brew cask install caskroom/fonts/font-fira-code
brew cask install forklift
brew cask install hammerspoon
brew cask install nextcloud
read -p "Press any key to continue... " -n1 -s

brew tap homebrew/services

# clipper
mkdir -p ~/Library/LaunchAgents
brew services start clipper
read -p "Press any key to continue... " -n1 -s

# install deps + plugins for neovim
pip3 install neovim
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh installer.sh ~/.config/nvim/dein
read -p "Press any key to continue... " -n1 -s
rm installer.sh

# set xterm/screen terminals to enable italic fonts in terminal
tic ~/dotfiles/other/xterm-256color.terminfo
read -p "Press any key to continue... " -n1 -s

# set terminal to xterm-256color!
# now restart your terminal and hope for the best

# set zsh to the default
sudo vim /etc/shells
read -p "Press any key to continue... " -n1 -s
chsh -s /usr/local/bin/zsh
read -p "Press any key to continue... " -n1 -s
/usr/bin/env zsh
read -p "Press any key to continue... " -n1 -s
sudo mv /etc/zshenv /etc/zprofile
read -p "Press any key to continue... " -n1 -s
sudo launchctl config user path $PATH
read -p "Press any key to continue... " -n1 -s
