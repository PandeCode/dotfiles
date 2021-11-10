#!/bin/sh

sudo rm -f /usr/local/bin/autostart.sh /usr/local/bin/envs.sh /etc/systemd/system/autostart.service /etc/systemd/system/envs.service

sudo ln -s ~/dotfiles/extras/autostart.sh /usr/local/bin/autostart.sh
sudo ln -s ~/dotfiles/extras/envs.sh /usr/local/bin/envs.sh

sudo ln -s ~/dotfiles/extras/autostart.service /etc/systemd/system/autostart.service
sudo ln -s ~/dotfiles/extras/envs.service /etc/systemd/system/envs.service

sudo systemctl enable autostart.service
sudo systemctl enable envs.service
