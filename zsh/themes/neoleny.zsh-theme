# oh-my-zsh theme from leny/pwendok - neoleny
# started at 17/07/2016

prompt_user_style() {
    if [[ $UID -eq 0 ]] then
        echo "%{$fg_bold[red]%}"
    else
        echo "%{$fg_no_bold[blue]%}"
    fi
}

_start_time=$SECONDS
prompt_preexec() {
    _start_time=$SECONDS
}

prompt_precmd() {
    RETVAL=$?
    timer_result=$(($SECONDS-$_start_time))
    if [[ $timer_result -ge 3600 ]]; then
        let "timer_hours = $timer_result / 3600"
        let "remainder = $timer_result % 3600"
        let "timer_minutes = $remainder / 60"
        let "timer_seconds = $remainder % 60"
        print -P "%{$fg_no_bold[magenta]%}◴ duration: %{$fg_bold[red]%}${timer_hours}h ${timer_minutes}m ${timer_seconds}s%{$reset_color%}"
    elif [[ $timer_result -ge 60 ]]; then
        let "timer_minutes = $timer_result / 60"
        let "timer_seconds = $timer_result % 60"
        print -P "%{$fg_no_bold[magenta]%}◴ duration: %{$fg_bold[yellow]%}${timer_minutes}m ${timer_seconds}s%{$reset_color%}"
    elif [[ $timer_result -gt 5 ]]; then
        print -P "%{$fg_no_bold[magenta]%}◴ duration: %{$fg_bold[green]%}${timer_result}s%{$reset_color%}"
    fi
    _start_time=$SECONDS
}

prompt_dir() {
    if [[ $PWD =~ "^${HOME}\/Works\/([^\/]+)\/([^\/]+)\/(.+)\$" ]]; then
        _path="./$match[3]"
        _path="%{$fg_no_bold[yellow]%}:%{$fg_no_bold[cyan]%}%$1<(…)<$_path%<<"
        echo "%{$fg_no_bold[magenta]%}$match[1]%{$reset_color%}/%{$fg_bold[cyan]%}$match[2]%{$reset_color%}$_path"
    elif [[ $PWD =~ "^${HOME}\/Works\/([^\/]+)\/([^\/]+)\$" ]]; then
        echo "%{$fg_no_bold[magenta]%}$match[1]%{$reset_color%}/%{$fg_bold[cyan]%}$match[2]%{$reset_color%}"
    elif [[ $PWD =~ "^${HOME}\/Works\/([^\/]+)\$" ]]; then
        echo "%{$fg_no_bold[magenta]%}$match[1]%{$reset_color%}"
    elif [[ $PWD =~ "^${HOME}\/.pwendok$" ]]; then
        echo "%{$fg_bold[red]%}pwendok%{$reset_color%}"
    else
        echo "%{$fg_no_bold[cyan]%}%$1<(…)<%~%<<"
    fi
}

prompt_invite() {
    if [[ $RETVAL -eq 0 ]]; then
        if [[ $UID -eq 0 ]]; then
            echo "%{$fg_bold[red]%}»"
        else
            echo "%{$fg_no_bold[blue]%}›"
        fi
    else
        echo "%{$fg_bold[red]%}⌦"
    fi
}

prompt_user() {
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        REMOTE_HOSTNAME="%{$fg_no_bold[cyan]%}@%{$fg_no_bold[white]%}$(hostname)"
    fi
    echo "$USER$REMOTE_HOSTNAME"
}

prompt_tooling() {
    local tooling
    tooling=()

    [[ -e gulpfile.js ]] && tooling+="gulp"
    [[ -e gulpfile.coffee ]] && tooling+="gulp"
    [[ -e gruntfile.js ]] && tooling+="grunt"
    [[ -e gruntfile.coffee ]] && tooling+="grunt"

    [[ -n "$tooling" ]] && echo "%{$fg_no_bold[yellow]%} • %{$fg_bold[white]%}$tooling"
}

autoload -Uz add-zsh-hook

add-zsh-hook preexec prompt_preexec
add-zsh-hook precmd prompt_precmd

_lineup=$'\e[1A'
_linedown=$'\e[1B'

# Prompt
PROMPT='%{$reset_color%}
$(prompt_user_style)$(prompt_user)%{$fg_no_bold[yellow]%} • %{$reset_color%}$(prompt_dir)%{$reset_color%}
$(prompt_invite) %{$reset_color%}'

RPROMPT='%{${_lineup}%}$(git_prompt_info)$(leny_git_prompt_status)$(dock-compose-status)$(prompt_tooling)%{$reset_color%}%{${_linedown}%}%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg_no_bold[green]%}git%{$fg_no_bold[yellow]%}: %{$fg_no_bold[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_SEPARATOR=""
ZSH_THEME_GIT_PROMPT_BRANCH=" %{$fg_no_bold[magenta]%}"
ZSH_THEME_GIT_PROMPT_STAGED=" %{$fg_no_bold[yellow]%}%{*%G%}"
ZSH_THEME_GIT_PROMPT_ADDED=" %{$fg_no_bold[yellow]%}%{*%G%}"
ZSH_THEME_GIT_PROMPT_DELETED=" %{$fg_no_bold[red]%}%{-%G%}"
ZSH_THEME_GIT_PROMPT_CONFLICTS=" %{$fg_bold[red]%}%{⟁%G%}"
ZSH_THEME_GIT_PROMPT_CHANGED=" %{$fg[blue]%}%{≠%G%}"
ZSH_THEME_GIT_PROMPT_BEHIND=" %{$fg_bold[purple]%}%{↓%G%}"
ZSH_THEME_GIT_PROMPT_AHEAD=" %{$fg_bold[cyan]%}%{↑%G%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED=" %{$fg_no_bold[white]%}%{+%G%}"
ZSH_THEME_GIT_PROMPT_MODIFIED=" %{$fg_no_bold[white]%}%{*%G%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg_bold[green]%}%{✓%G%}"
ZSH_THEME_GIT_PROMPT_DIRTY=""

ZSH_THEME_DOCKER_PROMPT_PREFIX="%{$fg_no_bold[yellow]%} • %{$fg_no_bold[green]%}docker%{$fg_no_bold[yellow]%}: %{$reset_color%}"
ZSH_THEME_DOCKER_PROMPT_NO_MACHINE="%{$fg_no_bold[red]%}no machine"
ZSH_THEME_DOCKER_CONTAINERS_COUNT_PREFIX="%{$fg_no_bold[green]%}"
ZSH_THEME_DOCKER_CONTAINERS_COUNT_SUFFIX=""
ZSH_THEME_DOCKER_NO_CONTAINERS="%{$fg_no_bold[red]%}0"
ZSH_THEME_DOCKER_PROMPT_SUFFIX="%{$reset_color%}"
