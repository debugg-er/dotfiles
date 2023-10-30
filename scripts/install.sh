#!/bin/bash

set -e
DOTFILES_DIR=~/dotfiles

Color_Off='\033[0m'
BGreen='\033[1;32m'
print_step() {
    echo -e "$BGreen🚀 $1$Color_Off"
    echo -e "$BGreen-----------------------------------------------$Color_Off"
}

print_step "Install installation tools"
sudo apt update
sudo apt install -y software-properties-common build-essential

print_step "Setting up apt repositories"
cat $DOTFILES_DIR/scripts/stuff/apt-repos | while read repo; do sudo add-apt-repository -y $repo; done

print_step "Install apt packages"
sudo apt install -y $(cat $DOTFILES_DIR/scripts/stuff/apt-packages)

print_step "Install nvm"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash

print_step "Install tpm"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

print_step "Install oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc

print_step "Install docker"
curl https://get.docker.com | bash -
sudo usermod -aG docker $USER

print_step "Download kubectl"
mkdir -p ~/.local/bin
curl -L -o ~/.local/bin/kubectl "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x ~/.local/bin/kubectl

print_step "Install keyd"
git clone https://github.com/rvaiya/keyd
cd keyd
make && sudo make install
systemctl enable keyd && sudo systemctl start keyd
cd .. && rm -rf keyd

print_step "Config ibus-bamboo"
ibus restart
env DCONF_PROFILE=ibus dconf write /desktop/ibus/general/preload-engines "['BambooUs', 'Bamboo']" && gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('ibus', 'Bamboo')]"

print_step "Install snap softwares"
cat $DOTFILES_DIR/scripts/stuff/snap-softwares | while read repo; do sudo snap install $repo; done
