set fish_greeting ""

set -x EDITOR "nvim"
set -x CLICOLOR 1
set -x LSCOLORS gxfxcxdxbxegedabagacad

set -x WORKS_PATH $HOME/Works
set -x HOMEBREW_CASK_OPTS "--appdir=/Applications"
set -x PYENV_ROOT $HOME/.pyenv

# PATH configuration (using fish_add_path to avoid duplicates)
fish_add_path /usr/local/opt/coreutils/libexec/gnubin
fish_add_path $HOME/.rover/bin
fish_add_path $HOME/.pyenv/bin
fish_add_path $HOME/.cargo/bin
fish_add_path /usr/local/sbin
fish_add_path $HOME/.dotmux/scripts

set -x GOROOT /opt/homebrew/opt/go/libexec
set -x GOPATH $WORKS_PATH/go
set -x GOBIN $GOPATH/bin
fish_add_path $GOBIN

set -x -U FZF_DEFAULT_COMMAND 'ag --hidden --ignore .git -g ""'

eval (/opt/homebrew/bin/brew shellenv)

complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'

# pnpm
set -gx PNPM_HOME "/Users/leny/Library/pnpm"
fish_add_path $PNPM_HOME
# pnpm end

# bun
set --export BUN_INSTALL "$HOME/.bun"
fish_add_path $BUN_INSTALL/bin

# Created by `pipx` on 2024-03-10 13:55:26
fish_add_path /Users/leny/.local/bin

# Added by Antigravity
fish_add_path /Users/leny/.antigravity/antigravity/bin

# Added by LM Studio CLI (lms)
fish_add_path /Users/leny/.lmstudio/bin
# End of LM Studio CLI section

