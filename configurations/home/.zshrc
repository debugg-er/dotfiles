# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
DISABLE_AUTO_UPDATE=true

ZSH_THEME="strug"
ZSH_DISABLE_COMPFIX="true"

export PATH=$PATH:$HOME/.local/bin

export EDITOR='vim'

source "$HOME/zsh/init.sh"
source "$HOME/zsh/plugin.sh"
source "$HOME/zsh/alias.sh"