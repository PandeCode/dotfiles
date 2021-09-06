#!/bin/env bash

pushd .

rm -fr ~/.config/spicetify
mkdir -p ~/.config/spicetify/Themes
mkdir -p ~/.config/spicetify/Extensions
mkdir -p ~/.config/spicetify/CustomApps

cd ~/.config/spicetify/Themes
svn checkout https://github.com/morpheusthewhite/spicetify-themes/trunk/Dribbblish
cd ..

cd ~/.config/spicetify/CustomApps
git clone https://github.com/3raxton/spicetify-custom-apps-and-extensions .
cd ..

find . -type f -regextype posix-extended -regex ".*\.(png|md|ps1)" -exec rm {} \;

popd
