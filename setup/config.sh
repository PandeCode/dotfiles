#!/bin/bash

rm -fr ~/.config/bat \
	~/.config/clangd \
	~/.config/conky \
	~/.config/dunst \
	~/.config/fish \
	~/.config/fontconfig \
	~/.config/gtk-2.0 \
	~/.config/gtk-3.0 \
	~/.config/gtk-4.0 \
	~/.config/hypr \
	~/.config/i3 \
	~/.config/i3blocks \
	~/.config/kitty \
	~/.config/nvim \
	~/.config/picom \
	~/.config/ranger \
	~/.config/rofi \
	~/.config/rustfmt \
	~/.config/sway \
	~/.config/sxhkd \
	~/.config/waybar \
	~/.config/xmonad \
	~/.config/xmobar

ln -s $DOTFILES/config/bat        ~/.config/bat
ln -s $DOTFILES/config/clangd     ~/.config/clangd
ln -s $DOTFILES/config/conky      ~/.config/conky
ln -s $DOTFILES/config/dunst      ~/.config/dunst
ln -s $DOTFILES/config/fish       ~/.config/fish
ln -s $DOTFILES/config/fontconfig ~/.config/fontconfig
ln -s $DOTFILES/config/gtk-2.0    ~/.config/gtk-2.0
ln -s $DOTFILES/config/gtk-3.0    ~/.config/gtk-3.0
ln -s $DOTFILES/config/gtk-4.0    ~/.config/gtk-4.0
ln -s $DOTFILES/config/hypr       ~/.config/hypr
ln -s $DOTFILES/config/i3         ~/.config/i3
ln -s $DOTFILES/config/i3blocks   ~/.config/i3blocks
ln -s $DOTFILES/config/kitty      ~/.config/kitty
ln -s $DOTFILES/config/nvim       ~/.config/nvim
ln -s $DOTFILES/config/picom      ~/.config/picom
ln -s $DOTFILES/config/ranger     ~/.config/ranger
ln -s $DOTFILES/config/rofi       ~/.config/rofi
ln -s $DOTFILES/config/rustfmt    ~/.config/rustfmt
ln -s $DOTFILES/config/sway       ~/.config/sway
ln -s $DOTFILES/config/sxhkd      ~/.config/sxhkd
ln -s $DOTFILES/config/waybar     ~/.config/waybar
ln -s $DOTFILES/config/xmonad     ~/.config/xmonad
ln -s $DOTFILES/config/xmobar     ~/.config/xmobar
