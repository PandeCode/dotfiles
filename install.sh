#!/bin/sh

cd ~
git clone https://github.com/PandeCode/dotfiles/main --bare
cd dotfiles.git/main
git submodule add main
cd main
git submodule update --force --recursive --init --remote

~/dotfiles.git/main/setup/system.sh
~/dotfiles.git/main/setup/config.sh
~/dotfiles.git/main/setup/spicetify.sh
~/dotfiles.git/main/setup/services.sh
~/dotfiles.git/main/setup/tmux.sh
~/dotfiles.git/main/setup/chromedriver.sh
