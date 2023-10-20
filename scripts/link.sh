#!/bin/bash

set -e

ln -snf ~/dotfiles/configurations/.config/* ~/.config
ln -sf  ~/dotfiles/configurations/.zshrc    ~/.zshrc
ln -sf  ~/dotfiles/configurations/keyd       /etc/keyd
