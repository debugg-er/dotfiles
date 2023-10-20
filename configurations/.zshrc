# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
DISABLE_AUTO_UPDATE=true

ZSH_THEME="strug"
ZSH_DISABLE_COMPFIX="true"

export HISTSIZE=1000000                   # Maximum events for internal history
export SAVEHIST=1000000                   # Maximum events in history file

# fzf
export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

### PATH
if [ -d "$HOME/.bin" ]; then
  PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ]; then
  PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.cargo/bin" ]; then
  PATH="$HOME/.cargo/bin:$PATH"
fi

export EDITOR='lvim'

source "$HOME/.config/zsh/omz.sh"
source "$HOME/.config/zsh/init.sh"
source "$HOME/.config/zsh/alias.sh"
