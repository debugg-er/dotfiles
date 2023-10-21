#!/bin/bash

set -e

mkdir -p ~/.local/bin
mkdir -p ~/.config

ln -svnf ~/dotfiles/configurations/.config/* ~/.config
ln -svf ~/dotfiles/configurations/.zshrc ~/.zshrc
ln -svf ~/dotfiles/configurations/keyd /etc/keyd
