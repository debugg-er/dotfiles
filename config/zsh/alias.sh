# alias w="cd \$(cat ~/.workspaces | fzf | awk '{print \$2}')"
# alias vim="fnm exec --using=default nvim"

alias fzf="fzf --height 50% --reverse"
alias t="trans -b :vi"
alias show-installed-package="comm -23 <(apt-mark showmanual | sort -u) <(gzip -dc /var/log/installer/initial-status.gz | sed -n 's/^Package: //p' | sort -u)"

alias k="kubectl"
alias kg="kubectl get"
alias kcuc="kubectl config use-context"
alias kcgc="kubectl config get-contexts"
alias kgp="kubectl get po"
alias kga="kubectl get all"

alias fkuc="kubectl config use-context \$(kubectl config get-contexts --no-headers=true | fzf | awk '{print \$1}')"
alias fkn="kubectl config set-context --current --namespace=\$(kubectl get namespaces --no-headers=true | fzf | awk '{print \$1}')"
alias fklog="kubectl logs -f \$(kubectl get po --no-headers=true | fzf | awk '{print \$1}')"
alias fkdelete="kubectl delete pod \$(kubectl get po --no-headers=true | fzf | awk '{print \$1}')"
alias fkexec="kubectl exec -it \$(kubectl get po --no-headers=true | fzf | awk '{print \$1}') -- "

# alias fssh="ssh \$(cat ~/.ssh/config | grep \"^Host\" | awk '{print \$2}' | fzf)"

alias vim="nvim"

fssh() {
  local host
  host=$(grep '^Host ' ~/.ssh/config | awk '{print $2}' | fzf) || return

  ssh "$host" "$@"
}

#vim() {
#    fnm exec --using=default nvim $@
#}

vertex_claude() {
    if command -v gcloud &> /dev/null; then
        LAST_RUN_FILE="$HOME/.gcloud_adc_last_login"
        if [[ ! -f "$LAST_RUN_FILE" || "$(date +%F)" != "$(cat $LAST_RUN_FILE)" ]]; then
            gcloud auth application-default login
            date +%F > "$LAST_RUN_FILE"
        fi
    fi
    CLAUDE_CODE_ENABLE_AUTO_MODE=1 CLAUDE_CODE_USE_VERTEX=1 CLOUD_ML_REGION=global ANTHROPIC_VERTEX_PROJECT_ID=prj-vnm-prod-be-sg-1 claude
}

glogw() {
    git log --date=iso-local --pretty=format:'%h|%an|%ad|%s' |
    while IFS='|' read hash author date message
    do
        printf '\033[0;32m%s\033[0m  \033[1;31m%-20s\033[0m %-28s \033[0;33m%s\033[0m\n' "$hash" "$author" "$date" "$message"
    done | less
}

fgbr() {
    branch=$(
        git for-each-ref refs/heads/ \
            --sort=-creatordate \
            --format='%(creatordate:short)|%(refname:short)|%(subject)' |
        column -t -s '|' |
        fzf |
        awk '{print $2}'
    )

    [[ -n "$branch" ]] && git switch "$branch"
}

fmvs() {
  local pkg
  local output
  local selection

  pkg="$(
    fzf \
      --phony \
      --prompt='package> ' \
      --bind 'start:reload(mvs query search "" 2>/dev/null | tail -n +2 || true)' \
      --bind 'change:reload(mvs query search {q} 2>/dev/null | tail -n +2 || true)'
  )" || return

  # Assume package name is the first column of the selected search result.
  pkg="$(printf '%s\n' "$pkg" | awk '{print $1}')"

  [[ -z "$pkg" ]] && return

  if ! output="$(mvs query versions "$pkg" 2>&1)"; then
    echo "$output" >&2
    return 1
  fi

  selection="$(
    printf '%s\n' "$output" |
      awk -v pkg="$pkg" 'NR > 2 {print pkg "@" $1}' |
      tac |
      fzf --prompt='version> '
  )" || return

  [[ -n "$selection" ]] && mvs shell "$selection"
}

cleanup_workspaces() {
    while IFS= read -r line; do
        dir_path=$(echo "$line" | awk '{print $2}')

        if [ -d "$dir_path" ]; then
            echo "$line"
        fi
    done < ~/.workspaces
}

wd() {
    cleaned_workspaces=$(cleanup_workspaces)
    selected_dir=$(echo $cleaned_workspaces | fzf | awk '{print $2}')
    if [[ $selected_dir == "" ]]; then
        return 1
    fi
    cd $selected_dir
    # vim
}

w() {
    wd
    vim
}

fgc() {
    b=$(git branch --all | fzf | xargs | sed 's/^remotes\/origin\///')
    git checkout $b
}

fk() {
    operator=$1
    shift

    if [[ -z "$operator" ]]; then
        echo "Missing arguments!"
        return 1
    fi

    #
    # Port forward
    #
    # Examples:
    #   fk pf
    #   fk pf -n argocd
    #   fk pf 8080 -n argocd
    #
    if [[ "$operator" == "pf" ]]; then
        localPort=""

        if [[ ${1:-} =~ ^[0-9]+$ ]]; then
            localPort=$1
            shift
        fi

        pod=$(
            kubectl get pod --no-headers=true "$@" |
                fzf |
                awk '{print $1}'
        )

        [[ -z "$pod" ]] && return 1

        ports=$(
            kubectl get pod "$pod" "$@" -o json |
                jq -r '
                    .spec.containers[].ports[]? |
                    [.containerPort, (.name // "")] |
                    @tsv
                '
        )

        if [[ -z "$ports" ]]; then
            echo "No ports found for pod: $pod"
            return 1
        fi

        if [[ $(printf '%s\n' "$ports" | wc -l) -eq 1 ]]; then
            targetPort=$(printf '%s\n' "$ports" | awk '{print $1}')
        else
            targetPort=$(
                printf '%s\n' "$ports" |
                    fzf |
                    awk '{print $1}'
            )
        fi

        [[ -z "$targetPort" ]] && return 1

        if [[ -z "$localPort" ]]; then
            localPort=$targetPort
        fi

        kubectl port-forward "$pod" "$localPort:$targetPort" "$@"
        return
    fi

    #
    # Exec into pod
    #
    # Namespace can be before or after the command:
    #
    #   fk exec -n argocd bash
    #   fk exec bash -n argocd
    #   fk exec sh --namespace argocd
    #   fk exec bash --namespace=argocd
    #
    # Use -- if the command itself needs -n:
    #
    #   fk exec -n argocd -- some-command -n foo
    #
    if [[ "$operator" == "exec" ]]; then
        kubectlArgs=()
        commandArgs=()

        while [[ $# -gt 0 ]]; do
            case "$1" in
                -n|--namespace)
                    if [[ -z ${2:-} ]]; then
                        echo "Missing namespace value!"
                        return 1
                    fi

                    kubectlArgs+=("$1" "$2")
                    shift 2
                    ;;

                --namespace=*)
                    kubectlArgs+=("$1")
                    shift
                    ;;

                --)
                    shift
                    commandArgs+=("$@")
                    break
                    ;;

                *)
                    commandArgs+=("$1")
                    shift
                    ;;
            esac
        done

        pod=$(
            kubectl get pod --no-headers=true "${kubectlArgs[@]}" |
                fzf |
                awk '{print $1}'
        )

        [[ -z "$pod" ]] && return 1

        if [[ ${#commandArgs[@]} -eq 0 ]]; then
            commandArgs=(sh)
        fi

        kubectl exec -it "$pod" "${kubectlArgs[@]}" -- "${commandArgs[@]}"
        return
    fi

    #
    # Normal resource operations
    #
    # Examples:
    #   fk g pod -n argocd
    #   fk d deployment -n argocd
    #   fk e svc -n argocd
    #   fk del pod -n argocd
    #
    resource=$1
    shift

    if [[ -z "$resource" ]]; then
        echo "Missing arguments!"
        return 1
    fi

    case "$operator" in
        d)
            operator="describe"
            ;;
        g)
            operator="get"
            ;;
        e)
            operator="edit"
            ;;
        del)
            operator="delete"
            ;;
    esac

    target=$(
        kubectl get "$resource" --no-headers=true "$@" |
            fzf |
            awk '{print $1}'
    )

    [[ -z "$target" ]] && return 1

    kubectl "$operator" "$resource" "$target" "$@"
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
    if [[ -n $TMUX ]]; then
        tmux rename-window $(basename $(pwd))
    fi

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

paste-image() {
  local filename="${1:-paste-$(date +%Y%m%d-%H%M%S).png}"
  local winpath

  winpath="$(wslpath -w "$PWD")"

  powershell.exe -NoProfile -Command "
    Add-Type -AssemblyName System.Windows.Forms
    if ([Windows.Forms.Clipboard]::ContainsImage()) {
      \$img = [Windows.Forms.Clipboard]::GetImage()
      \$img.Save('$winpath\\$filename')
    } else {
      Write-Error 'Clipboard does not contain an image.'
      exit 1
    }
  " >/dev/null

  if [[ $? -eq 0 ]]; then
    echo "Saved image to: $filename"
  fi
}


# eval $(thefuck --alias)
