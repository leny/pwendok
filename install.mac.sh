#!/bin/sh
# -- Mac Install

START_TIME=$SECONDS

# CWD
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo ""
echo ""
echo ""
echo "----- Install tools for XCode -----"

if [[ ! -d "$('xcode-select' -print-path 2>/dev/null)" ]]; then
    sudo xcode-select -switch /usr/bin
fi

echo ""
echo ""
echo ""
echo "----- Install homebrew & cask -----"

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor
brew tap caskroom/cask
brew install brew-cask
brew tap caskroom/versions

echo ""
echo ""
echo ""
echo "----- Install oh-my-zsh -----"

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
ln -sfv "$DOTFILES_DIR/zsh/themes/leny.zsh-theme" ~/.oh-my-zsh/themes/leny.zsh-theme

echo ""
echo ""
echo ""
echo "----- Install brew's -----"

brew update
brew upgrade
brew install $(cat "$DOTFILES_DIR/Brewfile"|grep -v "#")
brew cleanup

local binroot="$(brew --config | awk '/HOMEBREW_PREFIX/ {print $2}')"/bin

# htop
if [[ "$(type -P $binroot/htop)" ]] && [[ "$(stat -L -f "%Su:%Sg" "$binroot/htop")" != "root:wheel" || ! "$(($(stat -L -f "%DMp" "$binroot/htop") & 4))" ]]; then
    echo "- Updating htop permissions"
    sudo chown root:wheel "$binroot/htop"
    sudo chmod u+s "$binroot/htop"
fi

# bash
if [[ "$(type -P $binroot/bash)" && "$(cat /etc/shells | grep -q "$binroot/bash")" ]]; then
    echo "- Adding $binroot/bash to the list of acceptable shells"
    echo "$binroot/bash" | sudo tee -a /etc/shells >/dev/null
fi
# if [[ "$(dscl . -read ~ UserShell | awk '{print $2}')" != "$binroot/bash" ]]; then
#     echo "- Making $binroot/bash your default shell"
#     sudo chsh -s "$binroot/bash" "$USER" >/dev/null 2>&1
# fi

echo ""
echo ""
echo ""
echo "----- Install app's -----"

export HOMEBREW_CASK_OPTS="--appdir=/Applications"
brew cask install $(cat "$DOTFILES_DIR/Caskfile"|grep -v "#")
qlmanage -r

echo ""
echo ""
echo ""
echo "----- Install homebrew's bash -----"

grep "/usr/local/bin/bash" /private/etc/shells &>/dev/null || sudo bash -c "echo /usr/local/bin/bash >> /private/etc/shells"
chsh -s /usr/local/bin/bash

echo ""
echo ""
echo ""
echo "----- Install useful global npm packages -----"
npm install -g bower browserify codo coffee-script coffeegulp docco gadkod grunt grunt-cli grunt-devtools grunt-init gulp hexo mocha phantomas seve stylus tankipas vibox vows woazar yo
git clone https://github.com/gruntjs/grunt-init-gruntfile ~/.grunt-init/gruntfile
git clone https://github.com/gruntjs/grunt-init-gruntplugin ~/.grunt-init/gruntplugin
git clone https://github.com/gruntjs/grunt-init-node ~/.grunt-init/node
git clone https://github.com/gruntjs/grunt-init-jquery ~/.grunt-init/jquery

echo ""
echo ""
echo ""
echo "----- Install apm packages -----"
apm install package-sync

ELAPSED_TIME=$(($SECONDS - $START_TIME))

echo ""
echo ""
echo ""
echo "-----------------------------"
echo "----- Mac Install ended -----"
echo "-----------------------------"
echo "Duration : $(($ELAPSED_TIME/60)) min $(($ELAPSED_TIME%60)) sec"
echo "-------------------------"
