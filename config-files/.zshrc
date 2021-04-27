# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

DISABLE_AUTO_UPDATE=true

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="jreese"
# ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"
ZSH_DISABLE_COMPFIX="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.




plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

export EDITOR='vim'

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
# fi
# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# xmodmap
# if [ -z "$(xmodmap -pke | grep '108 = Mode_switch')" ]; then
#   /usr/bin/xmodmap ~/.Xmodmap
#   pkill terminal
# fi

alias killimwheel="kill $(ps aux | pgrep imwheel)"
alias fzf="fzf --height 50% --reverse"
alias vim="nvim"
alias docker="sudo docker"
alias docker-compose="sudo docker-compose"
alias t="trans -b :vi"
alias disable-keyboard="xinput float \"AT Translated Set 2 keyboard\""
alias enable-keyboard="xinput reattach \"AT Translated Set 2 keyboard\" 3"

enter() {
    xdg-open $1
}

isound() {
    pactl -- set-sink-volume 0 $1%
}

jva() {
    if javac $1
    then
        java ${1%.*}
    fi
}

runc() {
    if gcc -o ${1%.*} $1 -lm
    then
        ./${1%.*}
        rm $(sed -r "s/\.\w+$//g" <<< $1)
    fi
}

runcpp() {
    if g++ -o ${1%.*} $1
    then
        ./${1%.*}
        # rm $(sed -r "s/\.\w+$//g" <<< $1)
    fi
}

scriptcs() {
    if csc -nologo $1
    then
        mono ${1%.*}.exe
    fi
}


# Username Tag
prompt_context() {
    prompt_segment 'green' '#000' 'zsh'
}

# Prevent exit terminal when Ctrl+D
# set -o ignoreeof

# Alt+Endter to auto complete command
bindkey '^[^M' autosuggest-accept

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Open file with Vim
v() {
  local file
  file=$(fzf --query="$1") && vim "$file"
}

# cd to folder
fd() {
  local dir
  dir=$(find ${1:-*} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# show all hidden folder to 'cd'
fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

# Search in history
fh() {
  eval $(history | fzf +s | sed 's/ *[0-9]* *//')
}

# Kill a process
fk() {
  ps -ef | sed 1d | fzf -m | awk '{print $2}' | xargs kill -${1:-9}
}

# Checkout a branch
fbr() {
  local branches branch
  branches=$(git branch) &&
  branch=$(echo "$branches" | fzf +s +m) &&
  git checkout $(echo "$branch" | sed "s/.* //")
}

# Checkout a commit
fco() {
  local commits commit
  commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf +s +m -e) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}

# Search tags
ft() {
  local line
  [ -e tags ] &&
    line=$(grep -v "^!" tags | cut -f1-3 | cut -c1-80 | fzf --nth=1) &&
    $EDITOR $(cut -f2 <<< "$line")
}

# fq1 [QUERY]
# - Immediately select the file when there's only one match.
#   If not, start the fuzzy finder as usual.
fq1() {
  local lines
  lines=$(fzf --filter="$1" --no-sort)
  if [ -z "$lines" ]; then
    return 1
  elif [ $(wc -l <<< "$lines") -eq 1 ]; then
    echo "$lines"
  else
    echo "$lines" | fzf --query="$1"
  fi
}

# fe [QUERY]
# - Open the selected file with the default editor
#   (Bypass fuzzy finder when there's only one match)
fe() {
  local file
  file=$(fq1 "$1") && ${EDITOR:-vim} "$file"
}
