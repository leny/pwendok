set -x EDITOR "vim"
set -x CLICOLOR 1
set -x LSCOLORS gxfxcxdxbxegedabagacad

set -x WORKS_PATH "~/Works"
set -x GREP_OPTIONS "--color=auto"
set -x HOMEBREW_CASK_OPTS "--appdir=/Applications"
set -x GOPATH $home/.golang
set -x PATH (yarn global bin) (brew --prefix coreutils)/libexec/gnubin /usr/local/sbin $GOPATH $PATH
