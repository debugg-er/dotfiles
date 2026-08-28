[ -s "$HOME/.fzf.zsh" ] && source $HOME/.fzf.zsh
[ -s "$HOME/.gvm/scripts/gvm" ] && source "/home/khainguyen/.gvm/scripts/gvm"

if [ "$(which "fzf")" != "" ]; then
  export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git'"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  source <(fzf --zsh)
fi

autoload -Uz edit-command-line

zle -N edit-command-line


bindkey '^X^E' edit-command-line
bindkey ' ' magic-space

autoload -Uz compinit
compinit

# Allow completion in the middle of a word.
setopt COMPLETE_IN_WORD

# After completion, move cursor to the end.
setopt ALWAYS_TO_END

# Menu completion behavior.
zstyle ':completion:*' menu select

# Case-insensitive, partial-word, and substring completion.
#
# Examples:
#   cd project<Tab>
# can match:
#   my-super-project-folder/
#
#   vim config<Tab>
# can match:
#   some-long-configuration-file.yaml
#
zstyle ':completion:*' matcher-list \
  'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' \
  'r:|=*' \
  'l:|=* r:|=*'

# Show descriptions for completion groups.
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'

# Group different kinds of completions.
zstyle ':completion:*' group-name ''

# Use colors for file completion, based on LS_COLORS.
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Cache completion results where supported.
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.zsh/cache"

# Complete hidden files without requiring an explicit leading dot.
_comp_options+=(globdots)
