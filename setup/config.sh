#!/bin/bash

if [ ! -d "$DOTFILES" ]; then
	echo "DOTFILES not avaliable" 1>&2
	exit 1
fi

if [ ! -d "$XDG_CONFIG_HOME" ]; then
	echo "XDG_CONFIG_HOME not avaliable falling back to $HOME/.config" 1>&2
	if [ ! -d "$HOME" ]; then
		echo "HOME not avaliable" 1>&2
		exit 1
	fi
	XDG_CONFIG_HOME=$HOME/.config
fi

function create_symlink() {
	file=$1
	link=$2
	if [ ! -f "$file" ]; then
		echo "File '$file' not found." 1>&2
		return 1
	fi
	mkdir -p "$(dirname "$link")"
	rm -rdf "$link"
	ln -s "$file" "$link"
}

create_symlink "$DOTFILES/config/alacritty"  $XDG_CONFIG_HOME/alacritty
create_symlink "$DOTFILES/config/awesome"    $XDG_CONFIG_HOME/awesome
create_symlink "$DOTFILES/config/bat"        $XDG_CONFIG_HOME/bat
create_symlink "$DOTFILES/config/clangd"     $XDG_CONFIG_HOME/clangd
create_symlink "$DOTFILES/config/conky"      $XDG_CONFIG_HOME/conky
create_symlink "$DOTFILES/config/dunst"      $XDG_CONFIG_HOME/dunst
create_symlink "$DOTFILES/config/fish"       $XDG_CONFIG_HOME/fish
create_symlink "$DOTFILES/config/fontconfig" $XDG_CONFIG_HOME/fontconfig
create_symlink "$DOTFILES/config/gtk-2.0"    $XDG_CONFIG_HOME/gtk-2.0
create_symlink "$DOTFILES/config/gtk-3.0"    $XDG_CONFIG_HOME/gtk-3.0
create_symlink "$DOTFILES/config/gtk-4.0"    $XDG_CONFIG_HOME/gtk-4.0
create_symlink "$DOTFILES/config/hypr"       $XDG_CONFIG_HOME/hypr
create_symlink "$DOTFILES/config/i3"         $XDG_CONFIG_HOME/i3
create_symlink "$DOTFILES/config/i3blocks"   $XDG_CONFIG_HOME/i3blocks
create_symlink "$DOTFILES/config/kitty"      $XDG_CONFIG_HOME/kitty
create_symlink "$DOTFILES/config/nvim"       $XDG_CONFIG_HOME/nvim
create_symlink "$DOTFILES/config/picom"      $XDG_CONFIG_HOME/picom
create_symlink "$DOTFILES/config/ranger"     $XDG_CONFIG_HOME/ranger
create_symlink "$DOTFILES/config/rofi"       $XDG_CONFIG_HOME/rofi
create_symlink "$DOTFILES/config/rustfmt"    $XDG_CONFIG_HOME/rustfmt
create_symlink "$DOTFILES/config/sway"       $XDG_CONFIG_HOME/sway
create_symlink "$DOTFILES/config/sxhkd"      $XDG_CONFIG_HOME/sxhkd
create_symlink "$DOTFILES/config/waybar"     $XDG_CONFIG_HOME/waybar
create_symlink "$DOTFILES/config/xmonad"     $XDG_CONFIG_HOME/xmonad
create_symlink "$DOTFILES/config/xmobar"     $XDG_CONFIG_HOME/xmobar
