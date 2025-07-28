# ~/.bashrc: executed by bash(1) for non-login shells.
# See /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Add `~/bin` to the `$PATH`
if [ -d "$HOME/.local/bin" ] && [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
  PATH="$HOME/.local/bin:$PATH"
fi

if [ -r "$HOME/.env" ] && [ -f "$HOME/.env" ]; then
  source "$HOME/.env";
fi

# Import configuration files
for file in $HOME/.config/bash/{aliases,}.sh; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

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

# Set vim motion and vim as editor
set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'
VISUAL="nvim"
export EDITOR=$VISUAL

# Promptline
function promptline {
    PS1=$($HOME/.config/bash/prompt.sh)
}
PROMPT_COMMAND="promptline; $PROMPT_COMMAND"

# After each command, append to the history file, 
# in a already open tab this is only seen when I run some command to reload the history
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

set show-all-if-ambiguous on

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
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
export FZF_DEFAULT_OPTS='--color 16'
eval "$(fzf --bash)"

# devcontainer completion
if [[ -n "$DOTFILES_DEVCONTAINER_COMPLETION" ]]; then
  source $DOTFILES_PROJECTS_PATH$DOTFILES_DEVCONTAINER_COMPLETION
fi
