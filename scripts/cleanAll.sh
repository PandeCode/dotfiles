#!/bin/sh

sudo rm -fr ~/.npm ~/.lesshst ~/.cache/thumbnails ~/.local/share/baloo ~/.cache/cpython/ 
paru -Scc --noconfirm & paru -R (paru -Qtdq) --noconfirm
python3 -m pip cache purge
python2 -m pip cache purge
npm cache clean --force
yarn cache clean --force
go clean --modcache


