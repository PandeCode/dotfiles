#!/bin/sh

cd ~
git clone https://github.com/PandeCode/dotfiles --bare
cd dotfiles.git
git submodule add main
cd main
git submodule update --force --recursive --init --remote

DOTFILES=~/dotfiles.git/main

$DOTFILES/setup/system.sh
$DOTFILES/setup/config.sh
$DOTFILES/setup/spicetify.sh
$DOTFILES/setup/services.sh
$DOTFILES/setup/tmux.sh
$DOTFILES/setup/chromedriver.sh
