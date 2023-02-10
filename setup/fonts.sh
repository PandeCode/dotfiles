#!/bin/sh

mkdir -p ~/.fonts/
cd ~/.fonts/ || return 1
wget -c $(curl -fsSL https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | jq -r '.assets[] | .browser_download_url' | grep FantasqueSansMono.zip)
unzip FantasqueSansMono.zip
