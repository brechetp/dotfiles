#!/usr/bin/env bash

# everything needed for mutt
brew install gpgme
brew install isync
brew install khard
brew install msmtp
brew install mu
brew install neomutt
brew install ripmime
brew install w3m
brew install vdirsyncer

# python dependencies (for mutt)
sudo pip3 install -I urlscan

mkdir ~/Contacts
mkdir ~/Mail
mkdir ~/Mail/mailbox
mkdir ~/Mail/viu
ln -s ~/dotfiles/office/mutt ~/.mutt
ln -s ~/dotfiles/office/mbsyncrc ~/.mbsyncrc
ln -s ~/dotfiles/office/msmtprc ~/.msmtprc
ln -s ~/dotfiles/office/khard ~/.config/khard
ln -s ~/dotfiles/office/vdirsyncer ~/.vdirsyncer
