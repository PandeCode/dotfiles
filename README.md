# Dotfiles

Personal Backup of manjaro config files

Always clone to "~/dotfiles" or things will break.

```bash
git clone --recurse-submodules  https://github.com/PandeCode/dotfiles ~/dotfiles
cd ~/dotfiles
./install.sh
```

## Terminal Emulator

    - st (https://github.com/PandeCode/st-flexipatch)
    - kitty

## Display Server Server

    - Xorg

    Plan to use Wayland down the line. (dwl, waymonad)

## Login Manager

    - SDDM

## Desktop Environments

    - DWM (https://github.com/PandeCode/dwm-flexipatch)
    - Xmonad (when xmonad and xmonad-contrib are v0.17.0 on the package repos)
    - i3

## Goals

    - Turn into personal distro based on pure arch/artix (might take a while)
    - Use init system other than systemd (openrc, runit, s6, suite66)
    - Streamline install and setup process
    - Bootable USB Flash
