alias vi=nvim
alias vim=nvim
alias nvim-clean="ls ~/.local/state/nvim/swap/ | xargs -I {} rm -f ~/.local/state/nvim/swap/{}" 

alias open=xdg-open

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


# some more ls aliases
alias ll='ls -AlF'
alias la='ls -A'
alias l='ls -CF'
alias lsd="ls -lF ${colorflag} | grep --color=never '^d'"

alias rm='rm -i --preserve-root'

# Add an "alert" alias for long running commands.  
# Use like so: sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias -- -="cd -"

alias dl="cd ~/Downloads"
alias p="cd ~/Projects"

alias gits="git status"

alias devcontainer="bash ~/Projects/DevContainers/scripts/run-dev-container.sh"
