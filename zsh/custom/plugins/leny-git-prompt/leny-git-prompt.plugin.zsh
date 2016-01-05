# Get the status of the working tree
function leny_git_prompt_status() {
  local INDEX STATUS
  INDEX=$(command git status --porcelain -b 2> /dev/null)
  STATUS=""
  if $(echo "$INDEX" | command grep -E '^\?\? ' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNTRACKED"
  fi
  if $(echo "$INDEX" | grep '^A  ' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_ADDED"
  elif $(echo "$INDEX" | grep '^M  ' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_ADDED"
  fi
  if $(echo "$INDEX" | grep '^ M ' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_MODIFIED"
  elif $(echo "$INDEX" | grep '^AM ' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_MODIFIED"
  elif $(echo "$INDEX" | grep '^ T ' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_MODIFIED"
  fi
  if $(echo "$INDEX" | grep '^R  ' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_RENAMED"
  fi
  if $(echo "$INDEX" | grep '^ D ' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_DELETED"
  elif $(echo "$INDEX" | grep '^D  ' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_DELETED"
  elif $(echo "$INDEX" | grep '^AD ' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_DELETED"
  fi
  if $(command git rev-parse --verify refs/stash >/dev/null 2>&1); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_STASHED"
  fi
  if $(echo "$INDEX" | grep '^UU ' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNMERGED"
  fi
  if $(echo "$INDEX" | grep '^## .*ahead' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_AHEAD"
  fi
  if $(echo "$INDEX" | grep '^## .*behind' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_BEHIND"
  fi
  if $(echo "$INDEX" | grep '^## .*diverged' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_DIVERGED"
  fi
  echo $STATUS
}
