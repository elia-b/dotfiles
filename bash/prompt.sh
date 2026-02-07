#!/bin/bash

# Define text colors
BLACK='\e[30m'
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
BLUE='\e[34m'
MAGENTA='\e[35m'
CYAN='\e[36m'
WHITE='\e[37m'

# Define background colors
BG_BLACK='\e[40m'
BG_RED='\e[41m'
BG_GREEN='\e[42m'
BG_YELLOW='\e[43m'
BG_BLUE='\e[44m'
BG_MAGENTA='\e[45m'
BG_CYAN='\e[46m'
BG_WHITE='\e[47m'
BG_DEFAULT='\e[49m'
RESET='\e[0m'

# Extra Everforest colors: #7a8478 #859289 #9da9a0

THM_GREY0='\033[38;2;122;132;120m'
THM_GREY1='\033[38;2;133;146;137m'
THM_GREY2='\033[38;2;157;169;160m'
BG_THM_GREY0='\033[48;2;122;132;120m'
BG_THM_GREY1='\033[48;2;133;146;137m'
BG_THM_GREY2='\033[48;2;157;169;160m'

git_branch() {
  git rev-parse --is-inside-work-tree &>/dev/null || return 1

  local git_root prefix relpath branch
  git_root=$(git rev-parse --show-toplevel)
  prefix=$(git rev-parse --show-prefix)

  if [ -n "$prefix" ]; then
    relpath=${prefix%/}
  else
    relpath="."
  fi

  if ! git check-ignore -q "$relpath"; then
    git symbolic-ref --quiet --short HEAD
    return 0
  fi

  return 1
}

path="$PWD"
home="$HOME"

new_prompt=""

if [ "$(whoami)" == "container" ]; then
    new_prompt+="$BLUE$BLACK$BG_BLUE $DEV_CONTAINER_NAME " 
fi

IFS='/' read -r -a path_parts <<< "$path"
IFS='/' read -r -a home_parts <<< "$home"

if [[ ${#path_parts[@]} -gt 2 &&
      ${#home_parts[@]} -gt 2 &&
      ${path_parts[0]} == "${home_parts[0]}" &&
      ${path_parts[1]} == "${home_parts[1]}" &&
      ${path_parts[2]} == "${home_parts[2]}" ]]
then
    path_parts=("~" "${path_parts[@]:2}")
elif [[ ${path_parts[0]} == "" ]]; then
    path_parts[0]=" " 
fi

case "$path" in
    "$home")
        path_parts=(" ~") 
        ;;
    "$home/Downloads")
        path_parts=("~" "󰉍 Downloads") 
        ;;
    "$home/Projects")
        path_parts=("~" " Projects") 
        ;;
    "$home/Pictures")
        path_parts=("~" "󰉏 Pictures") 
        ;;
    "$home/app")
        path_parts=("~" " ") 
        ;;
    *)
        ;;
esac

if [ "$(whoami)" == "container" ]; then
    if (( 1 == ${#path_parts[@]})); then
        new_prompt+="$GREEN$BG_BLUE"
    else
        new_prompt+="$THM_GREY2$BG_BLUE"
    fi
else
    if (( 1 == ${#path_parts[@]})); then
        new_prompt+="$GREEN$BG_DEFAULT"
    else
        new_prompt+="$THM_GREY2$BG_DEFAULT"
    fi
fi

for (( i=0; i<${#path_parts[@]}; i++ )); do
    if (( i % 2 == 0 )); then
        if ((i != 0)); then
            if (( i == ${#path_parts[@]} - 1)); then
                new_prompt+="$BLACK$BG_GREEN "
            else
                new_prompt+="$BLACK$BG_THM_GREY2 "
            fi
        fi
        if (( i == ${#path_parts[@]} - 1)); then
            new_prompt+="$BLACK$BG_GREEN${path_parts[$i]}$GREEN$BG_DEFAULT"  
        elif (( i == ${#path_parts[@]} - 2)); then
            new_prompt+="$BLACK$BG_THM_GREY2${path_parts[$i]}$THM_GREY2$BG_GREEN"  
        else
            new_prompt+="$BLACK$BG_THM_GREY2${path_parts[$i]}$THM_GREY2$BG_THM_GREY0"  
        fi
    else
        if ((i != 0)); then
            if (( i == ${#path_parts[@]} - 1)); then
                new_prompt+="$BLACK$BG_GREEN "
            else
                new_prompt+="$BLACK$BG_THM_GREY0 "
            fi
        fi
        if (( i == ${#path_parts[@]} - 1)); then
            new_prompt+="$BLACK$BG_GREEN${path_parts[$i]}$GREEN$BG_DEFAULT"  
        elif (( i == ${#path_parts[@]} - 2)); then
            new_prompt+="$BLACK$BG_THM_GREY0${path_parts[$i]}$THM_GREY0$BG_GREEN"  
        else
            new_prompt+="$BLACK$BG_THM_GREY0${path_parts[$i]}$THM_GREY0$BG_THM_GREY2"  
        fi
    fi
done

if branch=$(git_branch); then
    new_prompt+="$GREEN$BG_DEFAULT  $branch" 
fi

if [ "$VIRTUAL_ENV_PROMPT" != "" ]; then
    new_prompt+="$YELLOW$BG_DEFAULT\n  $VIRTUAL_ENV_PROMPT"
fi

new_prompt+="$RESET\n\$ "

echo "${new_prompt}" 

