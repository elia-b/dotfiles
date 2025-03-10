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

function git_branch {
  git name-rev --name-only @
}

path=( $PWD )  
home=( $HOME )  
new_prompt=""

if [ "$(whoami)" == "container" ]; then
    new_prompt+="$BLACK$BG_RED 󰡨 $DEV_CONTAINER_NAME " 
fi

path_parts=(${path//\// })
home_parts=(${home//\// })
if [[ ${#path_parts[@]} -ge 2 && ${#home_parts[@]} -ge 2 && 
 "${path_parts[0]}" == "${home_parts[0]}" &&  "${path_parts[1]}" == "${home_parts[1]}" ]] 
then
    path_parts=("~" "${path_parts[@]:2}") 
fi
for (( i=0; i<${#path_parts[@]}; i++ )); do
    if (( i % 2 == 0 )); then
        if (( i == ${#path_parts[@]} - 1)); then
            new_prompt+="$BLACK$BG_THM_GREY2 ${path_parts[$i]} $THM_GREY2$BG_DEFAULT"  
        else
            new_prompt+="$BLACK$BG_THM_GREY2 ${path_parts[$i]} $THM_GREY2$BG_THM_GREY0"  
        fi
    else
        if (( i == ${#path_parts[@]} - 1)); then
            new_prompt+="$BLACK$BG_THM_GREY0 ${path_parts[$i]} $THM_GREY0$BG_DEFAULT"  
        else
            new_prompt+="$BLACK$BG_THM_GREY0 ${path_parts[$i]} $THM_GREY0$BG_THM_GREY2"  
        fi
    fi
done

if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]; then
    new_prompt+="$GREEN$BG_DEFAULT  $(git_branch)" 
fi

if [ "$VIRTUAL_ENV_PROMPT" != "" ]; then
    new_prompt+="$YELLOW$BG_DEFAULT\n  $VIRTUAL_ENV_PROMPT"
fi

new_prompt+="$RESET\n$ "

echo "${new_prompt}" 

