#!/bin/bash
read -p "Are you sure to restore? [y/n]: " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

# # ensure folders exist
# mkdir ${HOME}/.config/coc -p
# mkdir ${HOME}/.config/nvim -p

# cp ./config-files/{init.vim,coc-settings.json} ${HOME}/.config/nvim
# cp -r ./config-files/ultisnips ${HOME}/.config/coc

# cp ./config-files/{.ideavimrc,.imwheelrc,.zshrc,.tmux.conf,.eslintrc.json} ${HOME}

# if [ ! -d "${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
#     git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# fi

cp -rfv ./configurations/home/. $HOME

echo "OK"
