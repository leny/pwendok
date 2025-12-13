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

