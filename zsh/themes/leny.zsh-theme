# oh-my-zsh theme from leny/pwendok
# started at 01/11/2015

prompt_user_style() {
    if [[ $UID -eq 0 ]] then
        echo "%{$fg_bold[red]%}"
    else
        echo "%{$fg_no_bold[yellow]%}"
    fi
}

_start_time=$SECONDS
prompt_preexec() {
    _start_time=$SECONDS
}

prompt_precmd() {
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

autoload -Uz add-zsh-hook

add-zsh-hook preexec prompt_preexec
add-zsh-hook precmd prompt_precmd

_lineup=$'\e[1A'
_linedown=$'\e[1B'

# Prompt
PROMPT='
$(prompt_user_style)%n\
$fg_no_bold[magenta] @\
$fg_no_bold[white] %m\
$(prompt_user_style) :\
$fg_no_bold[cyan] %40<(…)<%~%<<%{$reset_color%}
$(prompt_user_style)➜ %{$reset_color%}'

RPROMPT='%{${_lineup}%}$(dock-compose-status)$(git_prompt_info)$(leny_git_prompt_status)%{${_linedown}%}%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_no_bold[green]%}git %{$fg_no_bold[yellow]%}› %{$fg_no_bold[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_SEPARATOR=""
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_no_bold[magenta]%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg_no_bold[yellow]%}%{*%G%}"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_no_bold[yellow]%}%{*%G%}"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_no_bold[red]%}%{-%G%}"
ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg_bold[red]%}%{⟁%G%}"
ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[blue]%}%{≠%G%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg_bold[purple]%} %{↓%G%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg_bold[cyan]%} %{↑%G%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_no_bold[white]%}%{+%G%}"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_no_bold[white]%}%{*%G%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%} %{✓%G%}"
ZSH_THEME_GIT_PROMPT_DIRTY=""

ZSH_THEME_DOCKER_PROMPT_PREFIX="%{$fg_no_bold[green]%}docker %{$fg_no_bold[yellow]%}›"
ZSH_THEME_DOCKER_PROMPT_NO_MACHINE="%{$fg_no_bold[red]%} no machine"
ZSH_THEME_DOCKER_CONTAINERS_COUNT_PREFIX="%{$fg_no_bold[cyan]%}"
ZSH_THEME_DOCKER_CONTAINERS_COUNT_SUFFIX="%{$fg_no_bold[magenta]%}containers up"
ZSH_THEME_DOCKER_NO_CONTAINERS="%{$fg_bold[yellow]%} no %{$fg_no_bold[magenta]%}container up"
ZSH_THEME_DOCKER_PROMPT_SUFFIX=" %{$fg_no_bold[yellow]%}- "
