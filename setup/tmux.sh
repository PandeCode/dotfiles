#!/bin/sh

rm -fr ~/.tmux ~/.tmux.conf
ln -s $DOTFILES/config/tmux/tmux.conf ~/.tmux.conf

$DOTFILES/config/tmux/install.sh
