#!/bin/bash

set -e

Color_Off='\033[0m'
BGreen='\033[1;32m'
print_step() {
    echo -e "$BGreen🚀 $1$Color_Off"
    echo -e "$BGreen-----------------------------------------------$Color_Off"
}

print_step "Install Nala package manager"
sudo apt-get update
sudo apt -y install nala

print_step "Install essensial dependencies"
sudo nala install -y zsh curl xclip ripgrep tmux git make wget snap xsel

print_step "Install Node version manager (nvm)"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
[ -s "$HOME/.nvm/nvm.sh" ] && \. "$HOME/.nvm/nvm.sh"

print_step "Install lastest NodeJS"
nvm install --lts

# print_step "Install global node's modules"
# npm install -g yarn
# yarn global add neovim eslint

print_step "Install alacritty"
sudo add-apt-repository ppa:aslatter/ppa -y
sudo nala install alacritty -y

print_step "Install alacritty theme"
mkdir -p ~/.config/alacritty/themes
git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes

print_step "Install tpm"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# print_step "Install fzf"
# git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
# yes | $HOME/.fzf/install

print_step "Install oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc

print_step "Install zsh-autosuggestions plugin"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

print_step "Download kubectl"
curl -L -o $HOME/.local/bin/kubectl "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

print_step "Install keyd"
git clone https://github.com/rvaiya/keyd
cd keyd
make && sudo make install
systemctl enable keyd && sudo systemctl start keyd
cd .. && rm -rf keyd
keyd reload

print_step "Install ibus-bamboo"
add-apt-repository ppa:bamboo-engine/ibus-bamboo -y
nala update
nala install -y ibus ibus-bamboo --install-recommends
ibus restart
env DCONF_PROFILE=ibus dconf write /desktop/ibus/general/preload-engines "['BambooUs', 'Bamboo']" && gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('ibus', 'Bamboo')]"

print_step "Install Snap Applications"
sudo snap install nvim --classic
