#!/bin/bash

set -e

Color_Off='\033[0m'
BGreen='\033[1;32m'
print_step() {
    echo -e "$BGreen🚀 $1$Color_Off"
    echo -e "$BGreen-----------------------------------------------$Color_Off"
}

print_step "Migrate configuration files"
source ./scripts/migrate.sh

print_step "Install Nala package manager"
sudo apt-get update
sudo apt -y install nala

print_step "Install essensial dependencies"
sudo nala install -y zsh curl xclip silversearcher-ag tmux git make wget

print_step "Install Node version manager (nvm)"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
[ -s "$HOME/.nvm/nvm.sh" ] && \. "$HOME/.nvm/nvm.sh"

print_step "Install lastest NodeJS"
nvm install --lts

print_step "Install global node's modules"
npm install -g yarn
yarn global add neovim eslint

print_step "Install tpm"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

print_step "Install fzf"
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
yes | $HOME/.fzf/install

print_step "Install oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc

print_step "Install zsh-autosuggestions plugin"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

print_step "Install ibus-bamboo"
sudo add-apt-repository ppa:bamboo-engine/ibus-bamboo
sudo nala update
sudo nala install ibus ibus-bamboo --install-recommends
ibus restart
env DCONF_PROFILE=ibus dconf write /desktop/ibus/general/preload-engines "['BambooUs', 'Bamboo']" && gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('ibus', 'Bamboo')]"
