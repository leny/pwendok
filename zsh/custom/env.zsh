# -- ENV

PATH="~/.pwendok/bin:`yarn global bin`:$(brew --prefix coreutils)/libexec/gnubin::/usr/local/sbin:${PATH}"
export PATH
export EDITOR="vim"
export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad

export WORKS_PATH="~/Works"

# Tell grep to highlight matches
export GREP_OPTIONS="--color=auto"

# Cask
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# completions
. <(npm completion)
. <(enpot completion)
eval "$(gulp --completion=zsh)"

# Go
export GOPATH=$HOME/.golang
export PATH=$PATH:$GOPATH/bin
