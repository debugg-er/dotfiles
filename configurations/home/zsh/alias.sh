#!/bin/bash

alias killimwheel="kill $(ps aux | pgrep imwheel)"
alias k="kubectl"
alias fzf="fzf --height 50% --reverse"
alias vim="nvim"
alias t="trans -b :vi"
alias disable-keyboard="xinput float \"AT Translated Set 2 keyboard\""
alias enable-keyboard="xinput reattach \"AT Translated Set 2 keyboard\" 3"
alias show-installed-package="comm -23 <(apt-mark showmanual | sort -u) <(gzip -dc /var/log/installer/initial-status.gz | sed -n 's/^Package: //p' | sort -u)"

alias kcuc="kubectl config use-context"
alias kcgc="kubectl config get-contexts"
alias kgp="kubectl get po"
alias kga="kubectl get all"

alias fkuc="kubectl config use-context \$(kubectl config get-contexts --no-headers=true | fzf | awk '{print \$1}')"
alias fkn="kubectl config set-context --current --namespace=\$(kubectl get namespaces --no-headers=true | fzf | awk '{print \$1}')"
alias fklog="kubectl logs \$(kubectl get po --no-headers=true | fzf | awk '{print \$1}')"
alias fkexec="kubectl exec -it \$(kubectl get po --no-headers=true | fzf | awk '{print \$1}') -- "
alias fgc="git checkout \$(git branch --all | fzf)"

alias mq="rabbitmqadmin --host=10.106.220.154 --username=user --password=password"

enter() {
    xdg-open $1
}

isound() {
    pactl -- set-sink-volume 0 $1%
}

jva() {
    if javac $1; then
        java ${1%.*}
    fi
}

runc() {
    if gcc -o ${1%.*} $1 -lm; then
        ./${1%.*}
        rm $(sed -r "s/\.\w+$//g" <<<$1)
    fi
}

runcpp() {
    if g++ -o ${1%.*} $1; then
        ./${1%.*}
        # rm $(sed -r "s/\.\w+$//g" <<< $1)
    fi
}

scriptcs() {
    if csc -nologo $1; then
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

# Open file with Vim
v() {
    local file
    file=$(fzf --query="$1") && vim "$file"
}

# cd to folder
fd() {
    local dir
    dir=$(find ${1:-*} -path '*/\.*' -prune \
        -o -type d -print 2>/dev/null | fzf +m) &&
        cd "$dir"
}

# show all hidden folder to 'cd'
fda() {
    local dir
    dir=$(find ${1:-.} -type d 2>/dev/null | fzf +m) && cd "$dir"
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
        $EDITOR $(cut -f2 <<<"$line")
}

# fq1 [QUERY]
# - Immediately select the file when there's only one match.
#   If not, start the fuzzy finder as usual.
fq1() {
    local lines
    lines=$(fzf --filter="$1" --no-sort)
    if [ -z "$lines" ]; then
        return 1
    elif [ $(wc -l <<<"$lines") -eq 1 ]; then
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

crfc() {
    mkdir -p $1
    touch $1/{index.tsx,$(basename "$1").css}
}

ytdl-playlist() {
    youtube-dl -ciw -f "bestvideo[filesize<100M]+bestaudio" \
        --max-downloads 12 \
        --merge-output-format mp4 \
        -o '%(id)s.%(ext)s' \
        $1
}

kns() {
    kubectl get namespace --no-headers |
        fzf | awk '{print $1}' |
        xargs -o -I % kubectl config set-context --current --namespace=%
}

kport() {
    kill -9 $(lsof -t -i:$1)
}

# auto load correct node version
chpwd() {
    if [[ -f .nvmrc && -r .nvmrc ]] && [[ $(cat .nvmrc) != $(node -v) ]]; then
        nvm use
    fi
}

fkill() {
    local process_id
    process_id=$(ps aux | fzf --multi --header='Select process to kill:' | awk '{print $2}')

    if [[ -n "$process_id" ]]; then
        echo "Killing process with ID: $process_id"
        kill "$process_id"
    else
        echo "No process selected."
    fi
}

n() {
    kubectl config set-context --current --namespace=$1
}
kport() {
    kill -9 $(lsof -t -i:$1)
}

# eval $(thefuck --alias)
