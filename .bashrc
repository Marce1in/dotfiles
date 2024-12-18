# Aliases

alias ls="ls --color"
alias repl="clj -M:repl/conjure"
alias nnn="nnn -e"
alias n="n -e"
alias grep='grep --color'
alias fgrep='fgrep --color'
alias egrep='egrep --color'
alias bat='bat --theme "Monokai Extended Origin"'
alias ls='lsd'
alias dwl="slstatus -s | dbus-run-session dwl"
alias ip="ip -c"
alias set-volume="wpctl set-volume @DEFAULT_AUDIO_SINK@ $1"

# Variables

export VI="nvim"
export EDITOR="nvim"

export LS_COLORS="di=1;34:ln=1;36:so=1;31:pi=1;33:ex=1;32:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

export NNN_PLUG='f:fzcd;d:dragdrop;'
export NNN_FCOLORS="c1e28d2e006033f7c6d6abc4"

export QT_QPA_PLATFORM="wayland-egl"
export ELM_DISPLAY="wl"
export SDL_VIDEODRIVER="wayland"

export GTK_THEME=Adwaita-dark

export HISTCONTROL=ignoreboth
export HISTSIZE=1000
export HISTFILESIZE=2000

export PATH=~/.local/bin/:$PATH

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

    function _python_venv() {
        if [ -n "$VIRTUAL_ENV" ]; then
            echo -e "$vermelho(${roxo}venv$vermelho)-"
        fi
    }

    function _git_branch() {
        local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)


        if [ -n "$branch" ]; then
            echo -e "$vermelho($verde$branch$vermelho)"
        fi
    }

    export PS1="$(_python_venv)$(_git_branch)$vermelho[$azul\W$vermelho]$amarelo\$ $branco"
}

export PROMPT_COMMAND="_prompt"

osc7_cwd() {
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


eval "$(~/.local/bin/mise activate bash)"
eval "$(fzf --bash)"
