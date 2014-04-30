# Terminal Customisation : put the following lines in ~.profile

# -- Aliases

alias c='clear'
alias wget='wget -c'

alias tree="find . | sed 's/[^/]*\//|   /g;s/| *\([^| ]\)/+--- \1/'"

alias pg='ps aux | grep'
alias pl='ps faux | less'

alias l="ls -Falh"
alias duh='du -h --max-depth=1'

alias ..='cd ..'
alias cd..="cd .."
alias ...='cd ~-'

alias cleansvn='find ./ -name ".svn" | xargs rm -Rf'

alias vup='vagrant up'
alias vdestroy='vagrant destroy'
alias vssh='vagrant ssh'
alias vdeploy='vagrant destroy && vagrant up && vagrant ssh'

alias enpm='npm --registry registry.npmjs.eu'

# Flush Directory Service cache
alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"

# -- Input RC

# Make Tab autocomplete regardless of filename case
set completion-ignore-case on

# List all matches in case multiple possible completions are possible
set show-all-if-ambiguous on

# Do not autocomplete hidden files unless the pattern explicitly begins with a dot
set match-hidden-files off

# -- Docker

export DOCKER_HOST=tcp://127.0.0.1:4243

# -- Prompt

export CLICOLOR=1
export PS1="\n\[$(tput setaf 3)\][\[$(tput setaf 8)\]\u\[$(tput sgr0)\]\[$(tput setaf 3)\]@\[$(tput sgr0)\]\[$(tput setaf 7)\]\h\[$(tput sgr0)\]\[$(tput setaf 3)\]:\[$(tput sgr0)\]\[$(tput bold)$(tput setaf 5)\]\w\[$(tput sgr0)\]\[$(tput setaf 3)\]]\[$(tput sgr0)\]\n\[$(tput setaf 3)\]➜\[$(tput sgr0)\] "
