# oh-my-zsh theme from leny/pwendok - powerline version
# started at 17/03/2016

# Powerline vars & segments functions
CURRENT_BG='NONE'
() {
  local LC_ALL="" LC_CTYPE="fr_BE.UTF-8"
  SEGMENT_SEPARATOR=$'\ue0b0'
}
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

_start_time=$SECONDS
prompt_preexec() {
    _start_time=$SECONDS
}

TIMER_DISPLAY=''
prompt_precmd() {
    timer_result=$(($SECONDS-$_start_time))
    if [[ $timer_result -ge 3600 ]]; then
        let "timer_hours = $timer_result / 3600"
        let "remainder = $timer_result % 3600"
        let "timer_minutes = $remainder / 60"
        let "timer_seconds = $remainder % 60"
        TIMER_DISPLAY="${timer_hours}h ${timer_minutes}m ${timer_seconds}s"
    elif [[ $timer_result -ge 60 ]]; then
        let "timer_minutes = $timer_result / 60"
        let "timer_seconds = $timer_result % 60"
        TIMER_DISPLAY="${timer_minutes}m ${timer_seconds}s"
    elif [[ $timer_result -gt 5 ]]; then
        TIMER_DISPLAY="${timer_result}s"
    else
        TIMER_DISPLAY=""
    fi
    _start_time=$SECONDS
}

autoload -Uz add-zsh-hook

add-zsh-hook preexec prompt_preexec
add-zsh-hook precmd prompt_precmd

# ----- define segments

# ------------------------------ STATUS

prompt_status() {
    [[ $UID -eq 0 ]] && prompt_segment black red ""
    [[ $RETVAL -ne 0 ]] && prompt_segment yellow black ""
    [[ $TIMER_DISPLAY != "" ]] && prompt_segment white black " $TIMER_DISPLAY%{$fg_no_bold[white]%}"
}

# ------------------------------ DIRECTORY

prompt_dir() {
    _bg='magenta'
    _fg='black'
    _dir='%40<(…)<%~% '
    prompt_segment $_bg $_fg $_dir
}

# ------------------------------ CONTEXT

prompt_context() {
    if [[ $UID -eq 0 ]] then
        echo "%{$fg_bold[red]%}›%{$reset_color%}"
    else
        echo "%{$fg_no_bold[yellow]%}›%{$reset_color%}"
    fi
}

# ------------------------------ GIT

prompt_git() {
    _bg='black'
    _fg='white'

    _git=$(git_prompt_info)$(leny_git_prompt_status)

    if [[ $(git_prompt_info) != '' ]]; then
        prompt_segment $_bg $_fg "$_git%{$fg_no_bold[black]%}"
    fi
}

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_no_bold[magenta]%} "
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_SEPARATOR=""
ZSH_THEME_GIT_PROMPT_BRANCH=""
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_no_bold[yellow]%} %{%G%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg_no_bold[yellow]%} %{%G%}"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_no_bold[red]%} %{%G%}"
ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg_bold[red]%} %{%G%}"
ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[blue]%} %{≠%G%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg_bold[cyan]%} %{%G%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg_bold[cyan]%} %{%G%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_no_bold[white]%} %{%G%}"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_no_bold[white]%} %{%G%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%} %{%G%}"
ZSH_THEME_GIT_PROMPT_DIRTY=""

# ------------------------------ DOCKER

prompt_docker() {
    _bg='cyan'
    _fg='black'
    _docker=$(dock-compose-status)
    if [ $(is_dock_project) ]; then
        prompt_segment $_bg $_fg "$_docker%{$fg_no_bold[cyan]%}"
    fi
}

ZSH_THEME_DOCKER_PROMPT_PREFIX=""
ZSH_THEME_DOCKER_PROMPT_NO_MACHINE=" no machine"
ZSH_THEME_DOCKER_CONTAINERS_COUNT_PREFIX=""
ZSH_THEME_DOCKER_CONTAINERS_COUNT_SUFFIX=" containers"
ZSH_THEME_DOCKER_NO_CONTAINERS="0 container"
ZSH_THEME_DOCKER_PROMPT_SUFFIX=""

# ------------------------------ /BUILD
build_prompt() {
  RETVAL=$?
  prompt_status
  prompt_dir
  prompt_git
  prompt_docker
  prompt_end
}

PROMPT='
%{%f%b%k%}$(build_prompt)
$(prompt_context) '
