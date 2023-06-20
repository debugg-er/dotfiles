#!/bin/bash
echo "Step 1/7 : Install utilities"
sudo apt-get update
sudo apt-get -y install zsh curl xclip silversearcher-ag tmux neovim
# sudo apt-get -y install snapd
echo "---------> done!"

echo "Step 3/7 : Install global node modules"
sudo npm install -g --silent neovim eslint
echo "---------> done!"

echo "Step 4/7 : Install vim-plug"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
echo "---------> done!"

echo "Step 5/7 : Install tpm"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "---------> done!"

echo "Step 6/7 : Install fzf"
git clone --depth 1 https://github.com/junegunn/fzf.git ${HOME}/.fzf
yes | ${HOME}/.fzf/install
echo "---------> done!"

echo "Step 7/7 : Install oh-my-zsh"
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "---------> done!"
