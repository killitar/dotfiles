if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting ""

set -gx TERM xterm-256color


zoxide init fish | source

alias ls="ls -p -G"
alias la="ls -A"
alias ll="ls -l"
alias lla="ll -A"
alias g=git
alias vim=nvim

if type -q eza
  alias ll "eza -l -g --icons"
  alias lla "ll -a"
end

alias ll="eza -l -g --icons"
alias lla="ll -a"
set -gx EDITOR nvim


# pnpm
set -gx PNPM_HOME "/home/kilitar/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
