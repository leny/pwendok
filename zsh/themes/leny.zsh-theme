# oh-my-zsh theme from leny/pwendok
# started at 01/11/2015

prompt_user_style() {
    if [[ $UID -eq 0 ]] then
        echo "%{$fg_bold[red]%}"
    else
        echo "%{$fg_no_bold[yellow]%}"
    fi
}

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_no_bold[yellow]%}•%{$fg_no_bold[green]%}git%{$fg_no_bold[magenta]%}›"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_SEPARATOR=" "
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_no_bold[magenta]%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg_no_bold[green]%}%{*%G%}"
ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg_bold[red]%}%{⟁%G%}"
ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[blue]%}%{≠%G%}"
ZSH_THEME_GIT_PROMPT_BEHIND=" %{$fg_bold[purple]%}%{↓%G%}"
ZSH_THEME_GIT_PROMPT_AHEAD=" %{$fg_bold[cyan]%}%{↑%G%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED=" %{$fg_no_bold[gray]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}%{✔%G%}"

# Prompt
PROMPT="
$(prompt_user_style)[\
%n\
$fg_no_bold[magenta]@\
$fg_no_bold[white]%m\
$(prompt_user_style):\
$fg_no_bold[cyan]%~\
$(git_prompt_info)\
$(prompt_user_style)]
$(prompt_user_style)➜ %{$reset_color%}"

RPROMPT=""
