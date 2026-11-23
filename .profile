#
# ~/.profile
#
# Login environment (POSIX sh): read once at login via ~/.bash_profile and
# inherited by sway and everything it launches.
# Interactive-only settings go in ~/.bashrc.

# Prepend a directory to PATH if it exists and is not already there
path_prepend() {
  case ":$PATH:" in
    *":$1:"*) ;;
    *) [ -d "$1" ] && PATH="$1:$PATH" ;;
  esac
}
path_prepend "$HOME/.local/bin"
path_prepend "$HOME/.opencode/bin"  # temporary until opencode is in the Arch repos
unset -f path_prepend

export PATH
export VISUAL="nvim"
export EDITOR="$VISUAL"
export DOTFILES_PROFILE=1  # lets ~/.bashrc know the environment is set

# Without a ~/.bash_profile (e.g. in containers) bash reads only this file at
# login, so hand over to ~/.bashrc for interactive login shells
if [ -n "$BASH_VERSION" ] && [ ! -e "$HOME/.bash_profile" ] && [ -f "$HOME/.bashrc" ]; then
  case $- in *i*) shopt -q login_shell && . "$HOME/.bashrc" ;; esac
fi
