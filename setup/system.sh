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

ln -s $DOTFILES/system/.bash_logout ~/.bash_logout
ln -s $DOTFILES/system/.bash_profile ~/.bash_profile
ln -s $DOTFILES/system/.bashrc ~/.bashrc
ln -s $DOTFILES/system/.flutter_settings ~/.flutter_settings
ln -s $DOTFILES/system/.gitconfig ~/.gitconfig
ln -s $DOTFILES/system/.inputrc ~/.inputrc
ln -s $DOTFILES/system/.profile ~/.profile
ln -s $DOTFILES/system/.pythonrc ~/.pythonrc
ln -s $DOTFILES/system/.sqliterc ~/.sqliterc
ln -s $DOTFILES/system/.vimrc ~/.vimrc
ln -s $DOTFILES/system/.Xresources ~/.Xresources
ln -s $DOTFILES/system/.Xmodmap ~/.Xmodmap
ln -s $DOTFILES/system/.xinitrc ~/.xinitrc
ln -s $DOTFILES/system/.gtkrc-2.0 ~/.gtkrc-2.0

rm -f /usr/bin/autostart.sh
ln -s $DOTFILES/extras/autostart.sh /usr/bin/autostart.sh
rm -f /lib/systemd/system/autostart.service
ln -s $DOTFILES/extras/autostart.service /lib/systemd/system/autostart.service

sudo systemctl enable autostart

sudo ln -s $DOTFILES/extras/envs.sh /etc/profile.d/envs.sh
