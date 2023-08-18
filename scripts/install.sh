#!/bin/bash

set -e

source ./scripts/lib.sh

BGreen='\033[1;32m'       # Green

log $BGreen "🚀 Install essensial dependencies"
apt-get update
apt -y install nala
nala install -y zsh curl xclip silversearcher-ag tmux neovim git make

log $BGreen "🚀 Install Node version manager (nvm)"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

log $BGreen "🚀 Install global node's modules"
nvm install --lts
npm install -g yarn
yarn global add neovim eslint

log $BGreen "🚀 Install vim-plug"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

log $BGreen "🚀 Install tpm"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

log $BGreen "🚀 Install fzf"
git clone --depth 1 https://github.com/junegunn/fzf.git ${HOME}/.fzf
yes | ${HOME}/.fzf/install

log $BGreen "🚀 Install oh-my-zsh"
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
