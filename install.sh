#!/bin/bash
echo "Step 1/7 : Install utilities"
sudo apt-get -y install zsh                 > /dev/null
sudo apt-get -y install curl                > /dev/null
sudo apt-get -y install xclip               > /dev/null
sudo apt-get -y install silversearcher-ag   > /dev/null
sudo apt-get -y install tmux                > /dev/null
sudo apt-get -y install neovim              > /dev/null
echo "---------> done!"

echo "Step 2/7 : Install nodejs"
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - > /dev/null
sudo apt-get -y install nodejs > /dev/null
echo "---------> done!"

echo "Step 3/7 : Install global node modules"
sudo npm install -g --silent neovim nodemon eslint http-server typescript ts-node
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
${HOME}/.fzf/install
echo "---------> done!"

echo "Step 7/7 : Install oh-my-zsh"
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "---------> done!"
