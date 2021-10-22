#!/bin/sh

sudo clear
CXX=g++ CC=gcc paru -Syyuu --overwrite "*" --noconfirm
python3 -m pip install --upgrade $(python3 -m pip list --outdated | sed "1,2d;s/ .*//;")
python2 -m pip install --upgrade $(python2 -m pip list --outdated | sed "1,2d;s/ .*//;")
cargo install $(cargo install --list | egrep '^[a-z0-9_-]+ v[0-9.]+:$' | cut -f1 -d' ')
gem update --system
go get -u && go mod tidy
sudo npm -g upgrade
yarn global upgrade
