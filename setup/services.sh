#!/bin/sh

sudo rm -f /usr/local/bin/autostart.sh /etc/systemd/system/autostart.service

sudo ln -s $DOTFILES/extras/autostart.sh /usr/local/bin/autostart.sh
sudo ln -s $DOTFILES/extras/autostart.service /etc/systemd/system/autostart.service

sudo systemctl enable autostart.service

