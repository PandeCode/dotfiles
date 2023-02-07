#!/bin/sh

save_pacman() {
	pacman -Qq > "$DOTFILES"/packages/pacman.all.txt
	echo "Saved pacman packages"
}

save_pnpm() {
	pnpm -g list --parseable | grep -Po '(?<=\/)(\w|-)+(?=@(\d|\.)*$)' > "$DOTFILES"/packages/pnpm.all.txt
	echo "Saved pnpm packages"
}

save_pip() {
	python3 -m pip list | sed "1,2d;s/ .*//;" > "$DOTFILES"/packages/pip.all.txt
	echo "Saved pip packages"
}

save_pip &
save_pnpm &
save_pacman
