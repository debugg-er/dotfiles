[ -s "$HOME/.fzf.zsh" ] && source $HOME/.fzf.zsh
[ -s "$HOME/.gvm/scripts/gvm" ] && source "/home/khainguyen/.gvm/scripts/gvm"

if [ "$(which "fzf")" != "" ]; then
  export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git'"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  source <(fzf --zsh)
fi

autoload -Uz edit-command-line
autoload -Uz compinit

zle -N edit-command-line


bindkey '^X^E' edit-command-line
bindkey ' ' magic-space

compinit

setopt COMPLETE_IN_WORD
setopt AUTO_MENU

zstyle ':completion:*' matcher-list \
  'm:{a-zA-Z}={A-Za-z}' \
  'r:|=*' \
  'l:|=* r:|=*'

zstyle ':completion:*:*:*:*:*' menu select
