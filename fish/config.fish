set fish_greeting ""

set -x EDITOR "nvim"
set -x CLICOLOR 1
set -x LSCOLORS gxfxcxdxbxegedabagacad

set -x WORKS_PATH $HOME/Works
set -x HOMEBREW_CASK_OPTS "--appdir=/Applications"
set -x PYENV_ROOT $HOME/.pyenv
set -x PATH /usr/local/opt/coreutils/libexec/gnubin $HOME/.pyenv/bin:$PATH $HOME/.cargo/bin /usr/local/sbin $PATH

set -x -U GOROOT /usr/local/Cellar/go/1.11/libexec
set -x -U GOPATH $WORKS_PATH/go
set -x -U GOBIN $GOPATH/bin

set -x -U FZF_DEFAULT_COMMAND 'ag --hidden --ignore .git -g ""'

function nvm
   bass source /usr/local/opt/nvm/nvm.sh --no-use ';' nvm $argv
end

set -x NVM_DIR ~/.nvm
nvm use default --silent

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.fish ]; and . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.fish

# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.fish ]; and . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.fish

# thefuck --alias | source

# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[ -f /Users/leny/Works/becode/becodeorg-stats/node_modules/tabtab/.completions/slss.fish ]; and . /Users/leny/Works/becode/becodeorg-stats/node_modules/tabtab/.completions/slss.fish
set -gx HOMEBREW_GITHUB_API_TOKEN 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

complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'

# pnpm
set -gx PNPM_HOME "/Users/leny/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# Created by `pipx` on 2024-03-10 13:55:26
set PATH $PATH /Users/leny/.local/bin
