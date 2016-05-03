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
}

prompt_user() {
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        REMOTE_HOSTNAME=" %{$fg_no_bold[cyan]%}@%{$fg_no_bold[white]%}$(hostname)"
    fi
    if [[ $UID -eq 0 ]]; then
        prompt_segment black red "$REMOTE_HOSTNAME%{$fg_no_bold[red]%}"
    else
        if [[ $USER != "leny" ]]; then
            prompt_segment black yellow "$USER$REMOTE_HOSTNAME%{$fg_no_bold[yellow]%}"
        else
            prompt_segment black yellow "$REMOTE_HOSTNAME%{$fg_no_bold[yellow]%}"
        fi
    fi
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
    if [[ $PWD =~ '^\/Users\/leny\/Works\/([^\/]+)\/([^\/]+)$' ]]; then
        _bg='blue'
        _fg='white'
        _dir="$match[1]/%{$fg_bold[yellow]%}$match[2]%{$fg_no_bold[blue]%}"
    elif [[ $PWD =~ '^\/Users\/leny\/Works\/([^\/]+)$' ]]; then
        _bg='blue'
        _fg='white'
        _dir="$match[1]%{$fg_no_bold[blue]%}"
    elif [[ $PWD =~ '^\/Users\/leny\/.pwendok$' ]]; then
        _bg='red'
        _fg='white'
        _dir="%{$fg_bold[yellow]%}.pwendok%{$fg_no_bold[red]%}"
    else
        _fg='black'
        _bg='cyan'
        _dir="%$1<(…)<%~%<<"
    fi

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

prompt_tooling() {
    local tooling
    tooling=()

    [[ -e gulpfile.js ]] && tooling+="gulp"
    [[ -e gulpfile.coffee ]] && tooling+="gulp"
    [[ -e gruntfile.js ]] && tooling+="grunt"
    [[ -e gruntfile.coffee ]] && tooling+="grunt"

    [[ -n "$tooling" ]] && prompt_segment white black "$tooling"
}

# ------------------------------ INVITE

prompt_invite() {
    if [[ $UID -eq 0 ]] then
        echo "\n%{$fg_bold[red]%}%{$reset_color%}"
    else
        echo "\n%{$fg_no_bold[yellow]%}%{$reset_color%}"
    fi
}

# ------------------------------ /BUILD

build_prompt() {
    RETVAL=$?

    local _termWidth _restChars
    (( _termWidth = ${COLUMNS} - 1 ))
    _restChars=$_termWidth

    # --- status (always printed)
    _statusPart=$(prompt_status)
    _statusCount=${#${(S)_statusPart//\%\{*\%\}}}
    (( _restChars -= $_statusCount ))
    prompt_status

    # --- user (always printed)
    _userPart=$(prompt_user)
    _userCount=${#${(S)_userPart//\%\{*\%\}}}
    (( _restChars -= $_userCount ))
    prompt_user

    # --- timer (always printed)
    # _timerCount=${#${(S)$(prompt_timer)//\%\{*\%\}}}
    _timerPart=$(prompt_timer)
    _timerCount=${#${(S)_timerPart//\%\{*\%\}}}
    (( _restChars -= $_timerCount ))
    prompt_timer

    # --- dir (printed to not exceed third of resting place)
    (( _dirTrim = $_restChars / 3 ))
    _dirPart=$(prompt_dir $_dirTrim)
    _dirCount=${#${(S)_dirPart//\%\{*\%\}}}
    (( _restChars -= $_dirCount ))
    prompt_dir $_dirTrim

    # --- git (printed in smaller form if no place rest)
    _gitPart=$(prompt_git)
    _gitCount=${#${(S)_gitPart//\%\{*\%\}}}
    if [[ $_gitCount -gt 0 ]]; then
        if [[ $_gitCount -gt (( $_restChars / 1.5 )) ]]; then
            _gitPart=$(prompt_segment black white "%{$fg_no_bold[magenta]%}%{$fg_no_bold[black]%}")
            _gitCount=${#${(S)_gitPart//\%\{*\%\}}}
            prompt_segment black white "%{$fg_no_bold[magenta]%}%{$fg_no_bold[black]%}"
        else
            prompt_git
        fi
    fi
    (( _restChars -= $_gitCount ))

    # --- docker (printed in smaller form if no place rest)
    _dockerPart=$(prompt_docker)
    _dockerCount=${#${(S)_dockerPart//\%\{*\%\}}}
    if [[ $_dockerCount -gt 0 ]]; then
        if [[ $_dockerCount -gt (( $_restChars / 1.25 )) ]]; then
            _dockerPart=$(prompt_segment cyan black "▣%{$fg_no_bold[cyan]%}")
            _dockerCount=${#${(S)_dockerPart//\%\{*\%\}}}
            prompt_segment cyan black "▣%{$fg_no_bold[cyan]%}"
        else
            prompt_docker
        fi
    fi
    (( _restChars -= $_dockerCount ))

    # --- tooling (printed if place rest)
    _toolingPart=$(prompt_tooling)
    _toolingCount=${#${(S)_toolingPart//\%\{*\%\}}}
    if [[ $_toolingCount -gt 0 ]]; then
        if [[ $_toolingCount -lt $_restChars ]]; then
            prompt_tooling
        fi
    fi
    (( _restChars -= $_toolingCount ))

    prompt_end

    prompt_invite
}

PROMPT='
%{%f%b%k%}$(build_prompt) '
