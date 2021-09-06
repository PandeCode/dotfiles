#!/bin/bash
pushd .

# Theme
rm -fr ~/.themes/Ant-Dracula
mkdir -p ~/.themes/
cd ~/.themes/
wget https://github.com/dracula/gtk/archive/master.zip
7z x master.zip
rm -f master.zip
mv gtk-master Ant-Dracula

# Icons
rm -fr ~/.icons/Ant-Dracula
mkdir -p ~/.icons
cd ~/.icons
wget https://github.com/dracula/gtk/files/5214870/Dracula.zip
7z x Dracula.zip
rm -fr Dracula.zip

popd
