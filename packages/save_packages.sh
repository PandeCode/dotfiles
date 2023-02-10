#!/bin/sh

save_pacman() {
	echo "$(comm -23 <(pacman -Qqett | sort) <(pacman -Qqg base -g base-devel | sort | uniq))" > "$DOTFILES"/packages/pacman.txt
	echo "Saved pacman packages"
}

save_aur() {
	pacman -Qm | awk '{ print $1 }' > "$DOTFILES"/packages/aur.txt
	echo "Saved aur packages"
}

save_pnpm() {
	pnpm -g list --parseable | grep -Po '(?<=\/)(\w|-)+(?=@(\d|\.)*$)' > "$DOTFILES"/packages/pnpm.txt
	echo "Saved pnpm packages"
}

save_pip() {
	python3 -m pip list | sed "1,2d;s/ .*//;" > "$DOTFILES"/packages/pip.txt
	echo "Saved pip packages"
}

save_pip &
save_pnpm &
save_pacman &
save_aur
