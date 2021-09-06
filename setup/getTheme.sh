#!/bin/bash
pushd

# bool function to test if the user is root or not (POSIX only)
is_user_root() { [ "$(id -u)" -eq 0 ]; }

if is_user_root; then
        echo 'You are the almighty root!'
        #exit 0 # implicit, here it serves the purpose to be explicit for the reader
else
        echo 'You are just an ordinary user.' >&2
        exit 1
fi

mkdir -p ~/dotfiles/config/alacritty
cd ~/dotfiles/config/alacritty
rm -f dracula.yml
wget https://raw.githubusercontent.com/dracula/alacritty/master/dracula.yml

# Qt5
mkdir -p ~/.config/qt5ct/colors/
cd ~/.config/qt5ct/colors/
rm -f Dracula.conf
wget https://raw.githubusercontent.com/dracula/qt5/master/Dracula.conf

# Icons
mkdir -p ~/.icons/
cd ~/.icons/
wget https://github.com/dracula/gtk/files/5214870/Dracula.zip
7z x Dracula.zip
rm -f Dracula.zip

gsettings set org.gnome.desktop.interface icon-theme "Dracula"

popd
