# ===============================
# File Listing Aliases
# ===============================
alias l='exa --icons --color -F -a --no-filesize --no-permissions --no-user --no-time'
alias ll='exa --git --icons --color -F -al'
alias t='exa --tree -F --icons'
alias ta='exa --tree -aF --icons'

# ===============================
# Directory Navigation Aliases
# ===============================
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias dl="cd ~/Downloads"
alias fm="vifm ."

# ===============================
# Editor Aliases
# ===============================
alias vi=nvim
alias vim=nvim
alias f='selected=$(fzf --preview="bat --theme="ansi" --color=always {}") && [ -n "$selected" ] && nvim "$selected"'
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
# Screen Capture
# ===============================
alias sshot='grim - | tee ~/Pictures/Screenshots/$(date "+%Y%m%d-%H%M%S").png | wl-copy'
alias sshotp='slurp | grim -g - - | tee ~/Pictures/Screenshots/$(date "+%Y%m%d-%H%M%S").png | wl-copy'
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

alias mergepdfs="gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress -sOutputFile=merged.pdf"
alias nvim-update='nvim --headless -c "Lazy! update" +qa'

# ===============================
# Personal
# ===============================
alias p="cd $DOTFILES_PROJECTS_PATH"
alias devcontainer="bash $DOTFILES_PROJECTS_PATH$DOTFILES_DEVCONTAINER"
alias bookmarksbackup="source $DOTFILES_PROJECTS_PATH$DOTFILES_BOOKMARKS_BACKUP"
