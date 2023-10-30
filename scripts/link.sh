#!/bin/bash

set -e

mkdir -p ~/.config
ln -svnf ~/dotfiles/config/alacritty ~/.config/alacritty
ln -svnf ~/dotfiles/config/tmux ~/.config/tmux
ln -svnf ~/dotfiles/config/nvim ~/.config/nvim
ln -svnf ~/dotfiles/config/zsh ~/.config/zsh

ln -svf ~/dotfiles/config/.zshrc ~/.zshrc
ln -svf ~/dotfiles/config/.vimrc ~/.vimrc
ln -svnf ~/dotfiles/config/.fonts ~/.fonts

mkdir -p ~/.oh-my-zsh/custom
ln -svf ~/dotfiles/config/.oh-my-zsh/plugins ~/.oh-my-zsh/custom/plugins

sudo mkdir -p /etc/keyd
sudo ln -svf ~/dotfiles/config/keyd/default.conf /etc/keyd/default.conf
