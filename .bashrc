# Prompt

function _prompt() {
	local azul='\[\033[0;36m\]'
	local vermelho='\[\033[0;31m\]'
	local roxo='\[\033[0;35m\]'
	local verde='\[\033[0;32m\]'
	local amarelo='\[\033[0;33m\]'
	local branco='\[\033[0;m\]'

	function _fg_jobs() {
		local jobs_count=$(jobs | grep -v zoxide | grep -v atuin | wc -l)
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
		if [[ "$TERM" == "xterm-kitty" || "$TERM_PROGRAM" == "kitty" ]]; then
			return
		fi


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

if command -v mise >/dev/null; then
	eval "$(mise activate bash)"
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
alias sail='sh $([ -f sail ] && echo sail || echo vendor/bin/sail)'
alias en='nvim .env'

# Variables

export VI=nvim
export EDITOR="nvim"
export TERMINAL=foot

export SSL_CERT_DIR="$HOME/.aspnet/dev-certs/trust:/etc/pki/tls/certs"

if command -v vivid >/dev/null; then
	export LS_COLORS="$(vivid generate gruvbox-dark)"
else
	export LS_COLORS="di=1;34:ln=1;36:so=1;31:pi=1;33:ex=1;32:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
fi

export QT_QPA_PLATFORM=wayland
export ELM_DISPLAY=wl
export SDL_VIDEODRIVER=wayland

export GTK_THEME=Adwaita:dark
export MOZ_ENABLE_WAYLAND=1

export CHROME_EXECUTABLE=chromium-browser

export HISTCONTROL=ignoreboth
export HISTSIZE=100
export HISTFILESIZE=5000

export ANDROID_HOME=$HOME/.android/sdk/

export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/rin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/tools
export PATH="$HOME/.local/bin:$PATH"
export _ZO_DOCTOR=0

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

export VENV_HOME="$HOME/.virtualenvs"

[[ -d $VENV_HOME ]] || mkdir $VENV_HOME

lsvenv() {
  ls -1 $VENV_HOME
}

venv() {
  if [ -f venv/bin/activate ]; then
      source ./venv/bin/activate
  elif [ -f .venv/bin/activate ]; then
      source ./.venv/bin/activate
  elif [ $# -eq 0 ]; then
      echo "Please provide venv name"
  else
      source "$VENV_HOME/$1/bin/activate"
  fi
}

mkvenv() {
  if [ $# -eq 0 ]
    then
      echo "Please provide venv name"
    else
      python3 -m venv $VENV_HOME/$1
  fi
}

rmvenv() {
  if [ $# -eq 0 ]
    then
      echo "Please provide venv name"
    else
      rm -r $VENV_HOME/$1
  fi
}


[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] &&
	source /usr/share/bash-completion/bash_completion

[[ $PS1 && -f /usr/share/bash-completion/completions/git ]] &&
	source /usr/share/bash-completion/completions/git

if [ -d "$HOME/.scripts" ]; then
	export PATH="$HOME/.scripts:$PATH"
fi

# pnpm
export PNPM_HOME="/home/pc/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

if command -v atuin >/dev/null; then
	[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
	eval "$(atuin init bash --disable-up-arrow)"
fi

## Flyio
if [ -d "$HOME/.fly" ]; then
	export FLYCTL_INSTALL="/home/pc/.fly"
	export PATH="$FLYCTL_INSTALL/bin:$PATH"
fi

# opencode
export PATH=/home/pc/.opencode/bin:$PATH
alias kimi-fleet="kimi --agent-file ~/.kimi/agents/orchestrator.yaml"

# Claude Code Aliases
alias claude-dev='claude --system-prompt "$(cat ~/.claude/contexts/dev.md 2>/dev/null || echo \"Focus on implementation. Write clean, minimal code.\")"'
alias claude-review='claude --system-prompt "$(cat ~/.claude/contexts/review.md 2>/dev/null || echo \"Focus on code review. Check for security, performance, and best practices.\")"'
alias claude-research='claude --system-prompt "$(cat ~/.claude/contexts/research.md 2>/dev/null || echo \"Explore thoroughly before acting. Gather context, understand patterns.\")"'
alias claude-cheap='claude --model haiku'
alias claude-smart='claude --model opus'

alias cc="claude --allow-dangerously-skip-permissions"

codex() {
	command mise exec node@25.8.2 -- codex "$@"
}

alias co="codex --dangerously-bypass-approvals-and-sandbox"

if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init bash)"; fi

export PATH="$PATH:/home/pc/.foundry/bin"

# Connect Haylou S30 headphones.
fone() {
	local fallback_mac="DE:15:E3:3D:7E:33"
	local mac="${1:-}"
	local sink_prefix
	local sink
	local out

	_scan_for_haylou_s30() {
		echo "Scanning for Haylou S30..."
		# --timeout stops discovery cleanly. Killing a persistent `scan on`
		# process can leave bluetoothctl waiting indefinitely on newer BlueZ.
		# The S30's LE beacon appears first; its classic A2DP endpoint can take
		# about 20 seconds to show up after pairing mode starts.
		bluetoothctl --timeout 25 scan on >/dev/null 2>&1 || true
	}

	_resolve_haylou_s30() {
		local candidate
		local info
		local named_candidate

		while read -r _ candidate _; do
			[ -n "$candidate" ] || continue
			info="$(bluetoothctl info "$candidate" 2>/dev/null)"
			if grep -Eqi '^[[:space:]]*(Name|Alias):.*HAYLOU[[:space:]]+S30' <<<"$info"; then
				named_candidate="${named_candidate:-$candidate}"
			fi
			if grep -Eqi '^[[:space:]]*(Name|Alias):.*HAYLOU[[:space:]]+S30' <<<"$info" &&
				grep -q "UUID: Audio Sink" <<<"$info"; then
				printf '%s\n' "$candidate"
				return 0
			fi
		done < <(bluetoothctl devices 2>/dev/null)

		if [ -n "$named_candidate" ]; then
			printf '%s\n' "$named_candidate"
			return 0
		fi

		# Keep the last known classic-audio address as a fallback only while
		# BlueZ still knows it. The S30 also advertises a changing LE address,
		# which cannot be used for A2DP pairing.
		if bluetoothctl info "$fallback_mac" >/dev/null 2>&1; then
			printf '%s\n' "$fallback_mac"
			return 0
		fi
		return 1
	}

	_connect_haylou_s30() {
		timeout 15s bluetoothctl --timeout 12 connect "$1" 2>&1
	}

	if [ -z "$mac" ]; then
		mac="$(_resolve_haylou_s30 || true)"
	fi

	if [ -n "$mac" ]; then
		echo "Using Haylou S30 at $mac"
		out="$(_connect_haylou_s30 "$mac")"
		printf '%s\n' "$out"
	fi

	if [ -z "$mac" ] || ! grep -Eq "Connection successful|Connected: yes" <<<"$out"; then
		_scan_for_haylou_s30
		if [ -z "$1" ]; then
			mac="$(_resolve_haylou_s30 || true)"
		fi

		if [ -z "$mac" ]; then
			echo "The S30 is nearby, but its classic-audio endpoint is not advertising." >&2
			echo "Disconnect it from other devices, hold its power button until pairing mode starts, then run fone again." >&2
			return 1
		fi

		echo "Using Haylou S30 at $mac"
		if ! bluetoothctl info "$mac" 2>/dev/null | grep -q "Paired: yes"; then
			echo "Pairing Haylou S30..."
			out="$(timeout 35s bluetoothctl --timeout 30 pair "$mac" 2>&1)"
			printf '%s\n' "$out"
			if ! grep -Eq "Pairing successful|Paired: yes" <<<"$out"; then
				echo "Pairing failed. Make sure the S30 is in pairing mode and not connected to another device." >&2
				return 1
			fi
		fi

		bluetoothctl trust "$mac" >/dev/null 2>&1 || true
		out="$(_connect_haylou_s30 "$mac")"
		printf '%s\n' "$out"
		if ! grep -Eq "Connection successful|Connected: yes" <<<"$out"; then
			echo "The S30 was found but the audio connection failed." >&2
			return 1
		fi
	fi

	if ! bluetoothctl info "$mac" 2>/dev/null | grep -q "Connected: yes"; then
		echo "The S30 did not remain connected." >&2
		return 1
	fi

	bluetoothctl trust "$mac" >/dev/null 2>&1 || true
	sink_prefix="bluez_output.${mac//:/_}"

	for _ in {1..15}; do
		sink="$(pactl list short sinks | awk -v prefix="$sink_prefix" '$2 ~ "^" prefix { print $2; exit }')"
		if [ -n "$sink" ]; then
			pactl set-default-sink "$sink"
			echo "Audio output set to Haylou S30."
			return 0
		fi
		sleep 1
	done

	echo "Connected, but PipeWire did not expose an audio sink for $mac" >&2
	return 1
}
export PATH="$PATH:$HOME/.dotnet/tools"

# >>> grok installer >>>
export PATH="$HOME/.grok/bin:$PATH"
[[ -r "$HOME/.grok/completions/bash/grok.bash" ]] && source "$HOME/.grok/completions/bash/grok.bash"
# <<< grok installer <<<
