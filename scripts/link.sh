#!/bin/bash

set -e

mkdir -p ~/.config
mkdir -p ~/.oh-my-zsh/custom

ln -svf ~/dotfiles/config/alacritty ~/.config/alacritty
ln -svf ~/dotfiles/config/tmux ~/.config/tmux
ln -svf ~/dotfiles/config/nvim ~/.config/nvim
ln -svf ~/dotfiles/config/zsh ~/.config/zsh

ln -svf ~/dotfiles/config/.zshrc ~/.zshrc
ln -svf ~/dotfiles/config/.vimrc ~/.vimrc
ln -svf ~/dotfiles/config/.fonts ~/.fonts

ln -svf ~/dotfiles/config/.oh-my-zsh/plugins ~/.oh-my-zsh/custom/plugins

sudo ln -svf ~/dotfiles/config/keyd /etc/keyd
