#!/bin/bash

set -e

CONFIG_DIR=~/dotfiles/config

mkdir -p ~/.config
ln -svnf $CONFIG_DIR/alacritty ~/.config/alacritty
ln -svnf $CONFIG_DIR/tmux ~/.config/tmux
ln -svnf $CONFIG_DIR/nvim ~/.config/nvim
ln -svnf $CONFIG_DIR/zsh ~/.config/zsh

ln -svf $CONFIG_DIR/.zshrc ~/.zshrc
ln -svf $CONFIG_DIR/.vimrc ~/.vimrc
ln -svnf $CONFIG_DIR/.fonts ~/.fonts

mkdir -p ~/.oh-my-zsh/custom
rm -rf ~/.oh-my-zsh/custom/plugins
ln -svnf $CONFIG_DIR/.oh-my-zsh/plugins ~/.oh-my-zsh/custom/plugins

sudo mkdir -p /etc/keyd
sudo ln -svf $CONFIG_DIR/keyd/default.conf /etc/keyd/default.conf
