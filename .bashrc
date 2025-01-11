#Evals

eval "$(zoxide init bash)"
eval "$(fzf --bash)"

# Aliases

alias ls="lsd"
alias repl="clj -M:repl/conjure"
alias nnn="nnn -e"
alias n="n -e"
alias grep='grep --color'
alias fgrep='fgrep --color'
alias egrep='egrep --color'
alias bat='bat --theme "gruvbox-dark"'
alias dwl="slstatus -s | dbus-run-session dwl"
alias ip="ip -c"
alias set-volume="wpctl set-volume @DEFAULT_AUDIO_SINK@ $1"
alias cd="z"
alias arc="distrobox-enter arch"

# Variables

export VI=nvim
export EDITOR=nvim
export TERMINAL=foot

export LS_COLORS="$(vivid generate gruvbox-dark)"

export QT_QPA_PLATFORM=wayland-egl
export ELM_DISPLAY=wl
export SDL_VIDEODRIVER=wayland

export GTK_THEME=Adwaita:dark
export MOZ_ENABLE_WAYLAND=1

export ANDROID_HOME=$HOME/.android/Android/

export HISTCONTROL=ignoreboth
export HISTSIZE=1000
export HISTFILESIZE=2000

export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/tools

# Options

shopt -s checkwinsize

# Functions

function _prompt() {
    local azul='\[\033[0;36m\]'
    local vermelho='\[\033[0;31m\]'
    local roxo='\[\033[0;35m\]'
    local verde='\[\033[0;32m\]'
    local amarelo='\[\033[0;33m\]'
    local branco='\[\033[0;m\]'

    function _fg_jobs() {
        local jobs_count=$(jobs | wc -l)
        if [ '0' != $jobs_count ]; then
            echo -e "$vermelho[$amarelo$jobs_count$vermelho]-"
        fi
    }

    function _python_venv() {
        if [ -n "$VIRTUAL_ENV_PROMPT" ]; then
            echo -e "$vermelho($roxo$VIRTUAL_ENV_PROMPT$vermelho)-"
        fi
    }

    function _git_branch() {
        local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)


        if [ -n "$branch" ]; then
            echo -e "$vermelho($verde$branch$vermelho)"
        fi
    }

    function _distro() {
        if [ -n "$CONTAINER_ID" ]; then
            echo -e "$vermelho($amarelo$CONTAINER_ID$vermelho)-"
        fi
    }

    export PS1="$(_fg_jobs)$(_distro)$(_python_venv)$(_git_branch)$vermelho[$azul\W$vermelho]$amarelo\$ $branco"
}

export PROMPT_COMMAND="_prompt"

function osc7_cwd() {
    local strlen=${#PWD}
    local encoded=""
    local pos c o
    for (( pos=0; pos<strlen; pos++ )); do
        c=${PWD:$pos:1}
        case "$c" in
            [-/:_.!\'\(\)~[:alnum:]] ) o="${c}" ;;
            * ) printf -v o '%%%02X' "'${c}" ;;
        esac
        encoded+="${o}"
    done
    printf '\e]7;file://%s%s\e\\' "${HOSTNAME}" "${encoded}"
}

export PROMPT_COMMAND=${PROMPT_COMMAND:+${PROMPT_COMMAND%;}; }osc7_cwd

function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

function venv() {
    if [ -f ./venv/bin/activate ]; then
        source ./venv/bin/activate
    elif [ -f ./.venv/bin/activate ]; then
        source ./.venv/bin/activate
    else
        echo "venv not founded :("
    fi
}
