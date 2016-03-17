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

TIMER_RESULT=''
prompt_precmd() {
    TIMER_RESULT=$(($SECONDS-$_start_time))
    _start_time=$SECONDS
}

autoload -Uz add-zsh-hook

add-zsh-hook preexec prompt_preexec
add-zsh-hook precmd prompt_precmd

# ----- define segments

# ------------------------------ STATUS

prompt_status() {
    [[ $RETVAL -ne 0 ]] && prompt_segment yellow black ""
    [[ $UID -eq 0 ]] && prompt_segment black red ""
}

prompt_timer() {
    if [[ $TIMER_RESULT -ge 3600 ]]; then
        let "timer_hours = $TIMER_RESULT / 3600"
        let "remainder = $TIMER_RESULT % 3600"
        let "timer_minutes = $remainder / 60"
        let "timer_seconds = $remainder % 60"
        TIMER_DISPLAY="${timer_hours}h ${timer_minutes}m ${timer_seconds}s"
        prompt_segment red white " $TIMER_DISPLAY%{$fg_no_bold[red]%}"
    elif [[ $TIMER_RESULT -ge 60 ]]; then
        let "timer_minutes = $TIMER_RESULT / 60"
        let "timer_seconds = $TIMER_RESULT % 60"
        TIMER_DISPLAY="${timer_minutes}m ${timer_seconds}s"
        prompt_segment yellow white " $TIMER_DISPLAY%{$fg_no_bold[yellow]%}"
    elif [[ $TIMER_RESULT -gt 5 ]]; then
        TIMER_DISPLAY="${TIMER_RESULT}s"
        prompt_segment green white " $TIMER_DISPLAY%{$fg_no_bold[green]%}"
    fi
}

# ------------------------------ DIRECTORY

prompt_dir() {
    _bg='blue'
    _fg='black'
    _dir='%40<(…)<%~% '

    prompt_segment $_bg $_fg $_dir
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

# ------------------------------ CONTEXT

prompt_context() {
    local symbols
    symbols=()

    [[ -e gulpfile.js ]] && symbols+="gulp"
    [[ -e gulpfile.coffee ]] && symbols+="gulp"
    [[ -e gruntfile.js ]] && symbols+="grunt"
    [[ -e gruntfile.coffee ]] && symbols+="grunt"

    [[ -n "$symbols" ]] && prompt_segment white black "$symbols"
}

# ------------------------------ /BUILD
build_prompt() {
  RETVAL=$?
  prompt_status
  prompt_timer
  prompt_dir
  prompt_git
  prompt_docker
  prompt_context
  prompt_end
}

# ------------------------------ INVITE

prompt_invite() {
    if [[ $UID -eq 0 ]] then
        echo "%{$fg_bold[red]%}%{$reset_color%}"
    else
        echo "%{$fg_no_bold[yellow]%}%{$reset_color%}"
    fi
}

PROMPT='
%{%f%b%k%}$(build_prompt)
$(prompt_invite) '
