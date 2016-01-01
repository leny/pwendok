function is_dock_project() {
    if [[ -e docker-compose.yml ]]; then
        echo 1
    fi
}

ZSH_THEME_DOCKER_PROMPT_PREFIX="dock:("
ZSH_THEME_DOCKER_PROMPT_NO_MACHINE="%{$fg_bold[red]%}no machine"
ZSH_THEME_DOCKER_NO_CONTAINERS="%{$fg_bold[red]%}no container"
ZSH_THEME_DOCKER_CONTAINERS_COUNT_PREFIX="%{$fg_bold[green]%}%{%G%} containers up"
ZSH_THEME_DOCKER_CONTAINERS_COUNT_SUFFIX=""
ZSH_THEME_DOCKER_PROMPT_SUFFIX=")"

function dock-compose-status() {
    if [ $(is_dock_project) ]; then
        echo -n $ZSH_THEME_DOCKER_PROMPT_PREFIX
        if [ $(docker-machine status dev) != "Running" ]; then
            echo -n $ZSH_THEME_DOCKER_PROMPT_NO_MACHINE
        else
            COUNTER=0
            docker-compose ps 2>/dev/null | tail -n+3 | while read line
            do
                if [[ $line == *"Up"* ]]; then
                    ((COUNTER++))
                fi
            done
            if [[ $COUNTER == 0 ]]; then
                echo -n $ZSH_THEME_DOCKER_NO_CONTAINERS
            else
                echo -n "$ZSH_THEME_DOCKER_CONTAINERS_COUNT_PREFIX $COUNTER $ZSH_THEME_DOCKER_CONTAINERS_COUNT_SUFFIX"
            fi
        fi
        echo -n $ZSH_THEME_DOCKER_PROMPT_SUFFIX
    fi
}
