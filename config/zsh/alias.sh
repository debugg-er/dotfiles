#!/bin/bash

# alias w="cd \$(cat ~/.workspaces | fzf | awk '{print \$2}')"
alias vim="fnm exec --using=default nvim"

alias fzf="fzf --height 50% --reverse"
alias t="trans -b :vi"
alias show-installed-package="comm -23 <(apt-mark showmanual | sort -u) <(gzip -dc /var/log/installer/initial-status.gz | sed -n 's/^Package: //p' | sort -u)"

alias k="kubectl"
alias kcuc="kubectl config use-context"
alias kcgc="kubectl config get-contexts"
alias kgp="kubectl get po"
alias kga="kubectl get all"

alias fkuc="kubectl config use-context \$(kubectl config get-contexts --no-headers=true | fzf | awk '{print \$1}')"
alias fkn="kubectl config set-context --current --namespace=\$(kubectl get namespaces --no-headers=true | fzf | awk '{print \$1}')"
alias fklog="kubectl logs -f \$(kubectl get po --no-headers=true | fzf | awk '{print \$1}')"
alias fkdelete="kubectl delete pod \$(kubectl get po --no-headers=true | fzf | awk '{print \$1}')"
alias fkexec="kubectl exec -it \$(kubectl get po --no-headers=true | fzf | awk '{print \$1}') -- "

cleanup_workspaces() {
    while IFS= read -r line; do
        dir_path=$(echo "$line" | awk '{print $2}')

        if [ -d "$dir_path" ]; then
            echo "$line"
        fi
    done < ~/.workspaces
}

w() {
    cleaned_workspaces=$(cleanup_workspaces)
    selected_dir=$(echo $cleaned_workspaces | fzf | awk '{print $2}')
    cd $selected_dir
    vim
}

fgc() {
    b=$(git branch --all | fzf | xargs | sed 's/^remotes\/origin\///')
    git checkout $b
}

fk() {
    operator=$1
    shift 1
    resource=$1
    shift 1

    if [[ "$operator" == "" || "$resource" == "" ]]; then
        echo "Missing required arguments, Ex. 'fk describe po'"
        return 1
    fi

    case "$operator" in
    "d")
        operator="describe"
        ;;
    "g")
        operator="get"
        ;;
    "e")
        operator="edit"
        ;;
    "del")
        operator="delete"
        ;;
    esac

    target=$(kubectl get $resource --no-headers=true | fzf | awk '{print $1}')
    kubectl $operator $resource $target $@
}

isound() {
    pactl -- set-sink-volume 0 $1%
}

# Username Tag
prompt_context() {
    prompt_segment 'green' '#000' 'zsh'
}

# Prevent exit terminal when Ctrl+D
# set -o ignoreeof

# Alt+Endter to auto complete command
bindkey '^[^M' autosuggest-accept

ytdl-playlist() {
    youtube-dl -ciw -f "bestvideo[filesize<100M]+bestaudio" \
        --max-downloads 12 \
        --merge-output-format mp4 \
        -o '%(id)s.%(ext)s' \
        $1
}

kport() {
    kill -9 $(lsof -t -i:$1)
}

# auto load correct node version
chpwd() {
    # if [[ -f .nvmrc && -r .nvmrc ]] && [[ $(cat .nvmrc) != $(node -v) ]]; then
    #     nvm use
    #     if [ $? -eq 3 ]; then
    #         nvm install
    #         npm install -g yarn @fsouza/prettierd eslint_d
    #     fi
    # fi
    # if [[ -n $TMUX ]]; then
    #     tmux rename-window $(basename $(pwd))
    # fi

    if [[ ! -d ".git" ]]; then
        return 1
    fi

    if [[ ! -e "~/.workspaces" ]]; then
        touch ~/.workspaces
    fi

    current_dir=$(pwd)
    workspace_existed=$(grep -R $current_dir ~/.workspaces)
    if [[ $workspace_existed ]]; then
        return 1
    fi

    printf '%-24s %s\n' $(basename $current_dir) $current_dir >> ~/.workspaces
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


# eval $(thefuck --alias)
