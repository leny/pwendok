#!/bin/sh
# -- Install

# CWD
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "----- Install vcprompt -----"

mkdir -pv "$DOTFILES_DIR/bin"
curl -L https://github.com/djl/vcprompt/raw/master/bin/vcprompt > "$DOTFILES_DIR/bin/vcprompt"
chmod +x "$DOTFILES_DIR/bin/vcprompt"

echo "\n\n\n----- Link dotfiles -----"

ln -sfhv "$DOTFILES_DIR/runcom/.bash_profile" ~
ln -sfhv "$DOTFILES_DIR/runcom/.inputrc" ~
ln -sfhv "$DOTFILES_DIR/editor/.editorconfig" ~
ln -sfhv "$DOTFILES_DIR/git/.gitconfig" ~
ln -sfhv "$DOTFILES_DIR/git/.gitignore_global" ~
ln -sfhv "$DOTFILES_DIR/hg/.hgignore_global" ~

echo "\n\n\n----- Install homebrew & cask -----"

ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
brew doctor
brew tap caskroom/cask
brew install brew-cask
brew tap caskroom/versions

echo "\n\n\n----- Install brew's -----"

brew bundle "$DOTFILES_DIR/Brewfile"

echo "\n\n\n----- Install app's -----"

export HOMEBREW_CASK_OPTS="--appdir=/Applications"
brew bundle "$DOTFILES_DIR/Caskfile"

echo "\n\n\n----- Install homebrew's bash -----"

grep "/usr/local/bin/bash" /private/etc/shells &>/dev/null || sudo bash -c "echo /usr/local/bin/bash >> /private/etc/shells"
chsh -s /usr/local/bin/bash

echo "\n\n\n----- Install useful global npm packages -----"
npm install -g bower browserify codo coffee-script coffeegulp docco grunt grunt-cli grunt-devtools grunt-init gulp hexo mocha phantomas stylus tankipas vibox vows woazar yo

echo "\n\n\n----- CLI Sublime Text Alias -----"
[ -f /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl ] && ln -sfhv /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl "$DOTFILES_DIR/bin/sublime"
