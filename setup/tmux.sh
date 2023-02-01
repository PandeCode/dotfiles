#!/bin/sh

rm -fr ~/tmux-config ~/.tmux ~/.tmux.conf
ln -s ~/dotfiles/config/tmux/tmux.conf ~/.tmux.conf

~/dotfiles/config/tmux/install.sh
