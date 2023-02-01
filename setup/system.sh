#!/bin/sh

rm -f \
    ~/.bash_logout \
    ~/.bashrc \
    ~/.gitconfig \
    ~/.pythonrc \
    ~/.vimrc \
    ~/.bash_profile \
    ~/.flutter_settings \
    ~/.inputrc \
    ~/.sqliterc \
    ~/.profile \
    ~/.Xresources \
    ~/.gtkrc-2.0 \
    ~/.Xmodmap \
    ~/.xinitrc

ln -s ~/dotfiles.git/main/system/.bash_logout ~/.bash_logout
ln -s ~/dotfiles.git/main/system/.bash_profile ~/.bash_profile
ln -s ~/dotfiles.git/main/system/.bashrc ~/.bashrc
ln -s ~/dotfiles.git/main/system/.flutter_settings ~/.flutter_settings
ln -s ~/dotfiles.git/main/system/.gitconfig ~/.gitconfig
ln -s ~/dotfiles.git/main/system/.inputrc ~/.inputrc
ln -s ~/dotfiles.git/main/system/.profile ~/.profile
ln -s ~/dotfiles.git/main/system/.pythonrc ~/.pythonrc
ln -s ~/dotfiles.git/main/system/.sqliterc ~/.sqliterc
ln -s ~/dotfiles.git/main/system/.vimrc ~/.vimrc
ln -s ~/dotfiles.git/main/system/.Xresources ~/.Xresources
ln -s ~/dotfiles.git/main/system/.Xmodmap ~/.Xmodmap
ln -s ~/dotfiles.git/main/system/.xinitrc ~/.xinitrc
ln -s ~/dotfiles.git/main/system/.gtkrc-2.0 ~/.gtkrc-2.0

rm -f /usr/bin/autostart.sh
ln -s ~/dotfiles.git/main/extras/autostart.sh /usr/bin/autostart.sh
rm -f /lib/systemd/system/autostart.service
ln -s ~/dotfiles.git/main/extras/autostart.service /lib/systemd/system/autostart.service

sudo systemctl enable autostart
