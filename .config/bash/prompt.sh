path=( $PWD )  
home=( $HOME )  
new_prompt=""
if [[ path == home ]]; then
    echo '${debian_chroot:+($debian_chroot)}\[\e[30;42m\] \w \[\033[00m\]\n\$ '
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
new_prompt+='\[\033[00m\]\n\$ '
echo "${new_prompt}"  # Return the colorized PS1 string


