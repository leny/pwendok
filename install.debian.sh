#!/bin/sh
# -- Debian Install

START_TIME=$SECONDS

# CWD
DOTFILES_DIR="$( cd "$( dirname "${(%):-%x}" )" && pwd )"

echo ""
echo ""
echo ""
echo "----- Finalize zsh installation -----"

rm ~/.zshrc
rm ~/.zshrc.pre-oh-my-zsh
ln -sfv "$DOTFILES_DIR/zsh/zshrc.mac" ~/.zshrc
ln -sfv "$DOTFILES_DIR/zsh/themes/leny.zsh-theme" ~/.oh-my-zsh/themes/leny.zsh-theme
ln -sfv "$DOTFILES_DIR/zsh/themes/leny-simple.zsh-theme" ~/.oh-my-zsh/themes/leny-simple.zsh-theme

echo ""
echo ""
echo ""
echo "----- Install packages -----"
apt-get update
apt-get install -y build-essential coreutils findutils git-extras htop lynx moreutils nmap ruby p7zip python3 svn tree wget

echo ""
echo ""
echo ""
echo "----- Install packages -----"
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
apt-get install -y nodejs

echo ""
echo ""
echo ""
echo "----- Install useful global npm packages -----"

npm install -g babel-cli babel-eslint bower browserify coffee-script enpot eslint gadkod grunt grunt-cli gulp hexo mocha phantomas seve stylus stylint tankipas vows watchify woazar yo

ELAPSED_TIME=$(($SECONDS - $START_TIME))

echo ""
echo ""
echo ""
echo "-----------------------------"
echo "----- Debian Install ended -----"
echo "-----------------------------"
echo "Duration : $(($ELAPSED_TIME/60)) min $(($ELAPSED_TIME%60)) sec"
echo "-------------------------"
