#!/usr/bin/env bash

function git_branch {
  git name-rev --name-only @
}

path=( $PWD )  
home=( $HOME )  
new_prompt=""
if [[ path == home ]]; then
    new_prompt+='$\[\e[30;42m\] \w' 
else
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
                new_prompt+="\[\e[30;42m\] ${path_parts[$i]} \[\e[32;49m\]"  
            else
                new_prompt+="\[\e[30;42m\] ${path_parts[$i]} \[\e[32;44m\]"  
            fi
        else
            if (( i == ${#path_parts[@]} - 1)); then
                new_prompt+="\[\e[30;44m\] ${path_parts[$i]} \[\e[34;49m\]"  
            else
                new_prompt+="\[\e[30;44m\] ${path_parts[$i]} \[\e[34;42m\]"  
            fi
        fi
    done
fi

if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]; then
    new_prompt+="\[\e[31;49m\]  $(git_branch)" 
fi

new_prompt+='\[\033[33;49m\]\n'

if [ "$VIRTUAL_ENV_PROMPT" != "" ]; then
    new_prompt+="  $VIRTUAL_ENV_PROMPT"
fi
new_prompt+='\[\033[00m\]\$ '
echo "${new_prompt}" 


