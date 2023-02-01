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

ln -s ~/dotfiles/system/.bash_logout ~/.bash_logout
ln -s ~/dotfiles/system/.bash_profile ~/.bash_profile
ln -s ~/dotfiles/system/.bashrc ~/.bashrc
ln -s ~/dotfiles/system/.flutter_settings ~/.flutter_settings
ln -s ~/dotfiles/system/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/system/.inputrc ~/.inputrc
ln -s ~/dotfiles/system/.profile ~/.profile
ln -s ~/dotfiles/system/.pythonrc ~/.pythonrc
ln -s ~/dotfiles/system/.sqliterc ~/.sqliterc
ln -s ~/dotfiles/system/.vimrc ~/.vimrc
ln -s ~/dotfiles/system/.Xresources ~/.Xresources
ln -s ~/dotfiles/system/.Xmodmap ~/.Xmodmap
ln -s ~/dotfiles/system/.xinitrc ~/.xinitrc
ln -s ~/dotfiles/system/.gtkrc-2.0 ~/.gtkrc-2.0

rm -f /usr/bin/autostart.sh
ln -s ~/dotfiles/extras/autostart.sh /usr/bin/autostart.sh
rm -f /lib/systemd/system/autostart.service
ln -s ~/dotfiles/extras/autostart.service /lib/systemd/system/autostart.service

sudo systemctl enable autostart
