#!/bin/bash

set -e

mkdir -p ~/.config

ln -snf ~/dotfiles/configurations/.config/* ~/.config
ln -sf  ~/dotfiles/configurations/.zshrc    ~/.zshrc
ln -sf  ~/dotfiles/configurations/keyd       /etc/keyd
