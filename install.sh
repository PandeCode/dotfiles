#!/bin/sh

cd ~ || return 1
git clone https://github.com/PandeCode/dotfiles --bare
cd dotfiles.git || return 1
git submodule add main
cd main || return 1
git submodule update --force --recursive --init --remote

DOTFILES=~/dotfiles.git/main

$DOTFILES/setup/system.sh
$DOTFILES/setup/config.sh
$DOTFILES/setup/services.sh
$DOTFILES/setup/fonts.sh
$DOTFILES/setup/tmux.sh
$DOTFILES/setup/spicetify.sh
$DOTFILES/setup/chromedriver.sh
