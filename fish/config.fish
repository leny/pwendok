set fish_greeting ""

set -x EDITOR "vim"
set -x CLICOLOR 1
set -x LSCOLORS gxfxcxdxbxegedabagacad

set -x WORKS_PATH "$HOME/Works"
set -x GREP_OPTIONS "--color=auto"
set -x HOMEBREW_CASK_OPTS "--appdir=/Applications"
set -x PATH (yarn global bin) (brew --prefix coreutils)/libexec/gnubin /usr/local/sbin $PATH

set -x -U GOPATH $HOME/.go
set -x -U GOBIN $GOPATH/bin
