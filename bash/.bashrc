# ~/.bashrc snippet — source this from your existing .bashrc:
#   [ -f ~/.dotfiles/bash/.bashrc ] && . ~/.dotfiles/bash/.bashrc

# History: bigger, deduplicated, shared across sessions
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend

# Sensible defaults
shopt -s checkwinsize
shopt -s globstar 2>/dev/null

export EDITOR=vim

# Load aliases
[ -f "$(dirname "${BASH_SOURCE[0]}")/.aliases" ] && . "$(dirname "${BASH_SOURCE[0]}")/.aliases"
