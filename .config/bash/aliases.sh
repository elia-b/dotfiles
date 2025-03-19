# ===============================
# File Listing Aliases
# ===============================
alias ll='ls --color=auto -AlF'
alias la='ls --color=auto -A'
alias l='ls --color=auto -CF'

# ===============================
# Directory Navigation Aliases
# ===============================
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias dl="cd ~/Downloads"

# ===============================
# Editor Aliases
# ===============================
alias vi=nvim
alias vim=nvim
alias v='selected=$(fzf --preview="bat --color=always {}") && [ -n "$selected" ] && nvim "$selected"'
alias nvim-clean="ls ~/.local/state/nvim/swap/ | xargs -I {} rm -f ~/.local/state/nvim/swap/{}" 

# ===============================
# Git Aliases
# ===============================
alias gits='git status'
alias gl='git log --oneline --graph --decorate'
alias gd='git diff'
alias gco='git checkout'
alias ga='git add'
alias gc='git commit -m'

# ===============================
# Miscellaneous Useful Aliases
# ===============================
alias open=xdg-open
alias cat="bat --color=always"
alias rm='rm -i --preserve-root'
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2|*.tbz2)   tar xvjf "$1" ;;
            *.tar.gz|*.tgz)     tar xvzf "$1" ;;
            *.bz2)              bunzip2 "$1" ;;
            *.rar)              unrar x "$1" ;;
            *.gz)               gunzip "$1" ;;
            *.tar)              tar xvf "$1" ;;
            *.zip)              unzip "$1" ;;
            *.7z)               7z x "$1" ;;
            *)                  echo "Cannot extract '$1'" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}
alias tx="tmux_new_or_attach"
tmux_new_or_attach() {
    if tmux ls &>/dev/null; then
        tmux attach -t 0
    else
        tmux new-session -s 0
    fi
}

# ===============================
# Personal
# ===============================
alias p="cd $DOTFILES_PROJECTS_PATH"
alias devcontainer="bash $DOTFILES_PROJECTS_PATH$DOTFILES_DEVCONTAINER"
