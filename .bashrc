# ~/.bashrc: executed by bash(1) for non-login shells.
# See /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# PATH and EDITOR live in ~/.profile (login environment).
# Load it here only if this shell did not inherit it (e.g. `podman exec bash`).
[[ -z $DOTFILES_PROFILE && -r ~/.profile ]] && source ~/.profile

# Aliases and prompt
[[ -r ~/.config/bash/aliases.sh ]] && source ~/.config/bash/aliases.sh
[[ -r ~/.config/bash/prompt.sh ]] && source ~/.config/bash/prompt.sh

# Don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
# For setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=32768
HISTFILESIZE=32768

# Append to the history file, don't overwrite it
shopt -s histappend

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# Vim motions (EDITOR is set in ~/.profile)
set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'

# Promptline (__promptline is defined in prompt.sh)
PROMPT_COMMAND="__promptline; $PROMPT_COMMAND"

# After each command, append to the history file, 
# in a already open tab this is only seen when I run some command to reload the history
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# Show completion candidates on the first Tab instead of the second
bind 'set show-all-if-ambiguous on'

# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# fzf completion
if command -v fzf >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
  export FZF_DEFAULT_OPTS='--color 16'
  eval "$(fzf --bash)"
fi

if command -v kpis >/dev/null 2>&1; then
  kpis
fi
