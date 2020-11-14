#!/bin/bash

echo "migrating config files..."

# ensure folders exist
mkdir ${HOME}/.config/coc -p
mkdir ${HOME}/.config/nvim -p

cp ./config-files/{init.vim,coc-settings.json} ${HOME}/.config/nvim
cp ./config-files/ultisnips ${HOME}/.config/coc

cp ./config-files/{.ideavimrc,.imwheelrc,.zshrc,.tmux.conf,.Xmodmap,.eslintrc.json} ${HOME}

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "migratting completed"
