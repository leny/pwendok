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

set -x NVM_DIR ~/.nvm

eval (/opt/homebrew/bin/brew shellenv)

# Lazy-load NVM - ne charge que quand tu utilises node/npm/npx/nvm
function __nvm_load
    functions -e node npm npx nvm __nvm_load
    bass source /opt/homebrew/opt/nvm/nvm.sh
    # Définir la vraie fonction nvm après le chargement
    function nvm
        bass source /opt/homebrew/opt/nvm/nvm.sh ';' nvm $argv
    end
end

function node
    __nvm_load
    command node $argv
end

function npm
    __nvm_load
    command npm $argv
end

function npx
    __nvm_load
    command npx $argv
end

function nvm
    __nvm_load
    nvm $argv
end

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

