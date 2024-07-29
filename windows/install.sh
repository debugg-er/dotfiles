#!/bin/bash

set -e

sudo pacman -S --noconfirm - < ./.pacman.programs

git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
cd ..
rm -rf yay-bin

yay -S --answerclean None --answerdiff None fnm-bin

print_step "Install tpm"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

print_step "Install oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc