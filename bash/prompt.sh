# Prompt line, sourced once by .bashrc.
# Defines __promptline, which .bashrc runs from PROMPT_COMMAND to set PS1.

source "$(dirname "$(realpath "${BASH_SOURCE[0]}")")/colors.sh"

__prompt_git_branch() {
  local prefix relpath
  # Fails outside a work tree (and inside .git), which hides the branch
  prefix=$(git rev-parse --show-prefix 2>/dev/null) || return 1

  if [ -n "$prefix" ]; then
    relpath=${prefix%/}
  else
    relpath="."
  fi

  if ! git check-ignore -q "$relpath"; then
    git symbolic-ref --quiet --short HEAD || git rev-parse --short HEAD 2>/dev/null
    return 0
  fi

  return 1
}

__promptline() {
local path="$PWD" home="$HOME" new_prompt="" branch i
local -a path_parts home_parts

if [ "$USER" == "container" ]; then
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
    path_parts=("~" "${path_parts[@]:3}")
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

if [ "$USER" == "container" ]; then
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

if branch=$(__prompt_git_branch); then
    new_prompt+="$GREEN$BG_DEFAULT  $branch" 
fi

if [ "$VIRTUAL_ENV_PROMPT" != "" ]; then
    new_prompt+="$YELLOW$BG_DEFAULT\n  $VIRTUAL_ENV_PROMPT"
fi

new_prompt+="$RESET\n\$ "

PS1="${new_prompt}"
}

