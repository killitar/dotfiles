if status is-interactive
  # Commands to run in interactive sessions can go here
end

set fish_greeting ""

set -gx TERM xterm-256color

alias ls="ls -p -G"
alias la="ls -A"
alias ll="ls -l"
alias lla="ll -A"
alias g=git
alias vim=nvim
alias hx=helix

if type -q eza
  alias ll "eza -l -g --icons"
  alias lla "ll -a"
end

alias ll="eza -l -g --icons"
alias lla="ll -a"
set -gx EDITOR nvim

# yazi
function yy
  set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		cd -- "$cwd"
	end
	rm -f -- "$tmp"
end

# pnpm
set -gx PNPM_HOME "/home/kilitar/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

zoxide init fish | source

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
