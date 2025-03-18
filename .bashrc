# Prompt

function _prompt() {
	local azul='\[\033[0;36m\]'
	local vermelho='\[\033[0;31m\]'
	local roxo='\[\033[0;35m\]'
	local verde='\[\033[0;32m\]'
	local amarelo='\[\033[0;33m\]'
	local branco='\[\033[0;m\]'

	function _fg_jobs() {
		local jobs_count=$(jobs | grep -v zoxide | wc -l)
		if [ '0' != $jobs_count ]; then
			echo -e "$vermelho[$amarelo$jobs_count$vermelho]-"
		fi
	}

	function _python_venv() {
		if [ -n "$VIRTUAL_ENV_PROMPT" ]; then
			echo -e "$vermelho(${roxo}venv$vermelho)-"
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

	function osc7_cwd() {
		local strlen=${#PWD}
		local encoded=""
		local pos c o
		for ((pos = 0; pos < strlen; pos++)); do
			c=${PWD:$pos:1}
			case "$c" in
			[-/:_.!\'\(\)~[:alnum:]]) o="${c}" ;;
			*) printf -v o '%%%02X' "'${c}" ;;
			esac
			encoded+="${o}"
		done
		printf '\[\e]7;file://%s%s\e\\' "${HOSTNAME}" "${encoded}"
	}

	export PS1="\[\033]0;$(pwd)\007$(_fg_jobs)$(_distro)$(_python_venv)$(_git_branch)$vermelho[$azul\W$vermelho]$amarelo\$ $branco$(osc7_cwd)"
}

export PROMPT_COMMAND="history -a; _prompt"

#Evals

if [ -f ~/.local/bin/mise ]; then
	eval "$(~/.local/bin/mise activate bash)"
	eval "$(mise completion bash)"
fi

if command -v zoxide >/dev/null; then
	eval "$(zoxide init bash)"
fi

if command -v fzf >/dev/null; then
	eval "$(fzf --bash)"
fi

# Aliases

if command -v lsd >/dev/null; then
	alias ls="lsd"
fi

if command -v z >/dev/null; then
	alias cd="z"
fi

alias maildebug="python -m aiosmtpd -c DebuggingServer -n localhost:1025"
alias repl="clj -M:repl/conjure"
alias nnn="nnn -e"
alias n="n -e"
alias grep='grep --color'
alias fgrep='fgrep --color'
alias egrep='egrep --color'
alias bat='bat --theme "gruvbox-dark"'
alias dwl=" export XDG_CURRENT_DESKTOP=sway && \
systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP && \
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway && \
slstatus -s | dwl
"
alias ip="ip -c"
alias set-volume="wpctl set-volume @DEFAULT_AUDIO_SINK@ $1"
alias arc="distrobox-enter arch"

# Variables

export VI=nvim
export EDITOR=nvim
export TERMINAL=foot

if command -v vivid >/dev/null; then
	export LS_COLORS="$(vivid generate gruvbox-dark)"
else
	export LS_COLORS="di=1;34:ln=1;36:so=1;31:pi=1;33:ex=1;32:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
fi

export QT_QPA_PLATFORM=wayland-egl
export ELM_DISPLAY=wl
export SDL_VIDEODRIVER=wayland

export GTK_THEME=Adwaita:dark
export MOZ_ENABLE_WAYLAND=1

export ANDROID_HOME=$HOME/.android/Android/

export HISTCONTROL=ignoreboth
export HISTSIZE=100
export HISTFILESIZE=5000

export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/tools

# Options

shopt -s checkwinsize
shopt -s histappend
complete -cf sudo

# Functions

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


[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] &&
	source /usr/share/bash-completion/bash_completion

[[ $PS1 && -f /usr/share/bash-completion/completions/git ]] &&
	source /usr/share/bash-completion/completions/git
