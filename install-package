#!/bin/bash
echo "installing utilities..."
sudo apt-get -y install zsh curl xclip silversearcher-ag tmux > /dev/null
echo "installing completed!"

echo "installing neovim..."
sudo apt-get -y neovim > /dev/null
sudo cp /usr/bin/nvim /usr/bin/vim
echo "installing completed"

echo "installing nodejs..."
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - > /dev/null
sudo apt-get -y install nodejs > /dev/null
echo "installing completed"

echo "installing node global module..."
sudo npm install -g --silent neovim nodemon eslint http-server typescript ts-node
echo "install completed"

echo "installing vim-plug..."
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
echo "installing completed"

echo "installing fzf"
git clone --depth 1 https://github.com/junegunn/fzf.git ${HOME}/.fzf
${HOME}/.fzf/install
echo "installing completed"

echo "installing oh-my-zsh..."
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "installing completed!"
