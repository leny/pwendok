#!/bin/sh
# -- Install

START_TIME=$SECONDS

# CWD
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo ""
echo ""
echo ""
echo "----- Install vcprompt -----"

mkdir -pv "$DOTFILES_DIR/bin"
curl -L https://github.com/djl/vcprompt/raw/master/bin/vcprompt > "$DOTFILES_DIR/bin/vcprompt"
chmod +x "$DOTFILES_DIR/bin/vcprompt"

echo ""
echo ""
echo ""
echo "----- Install sote -----"

git clone https://github.com/leny/sote ~/.sote

echo ""
echo ""
echo ""
echo "----- Link dotfiles -----"

ln -sfhv "$DOTFILES_DIR/runcom/.bash_profile" ~
ln -sfhv "$DOTFILES_DIR/runcom/.inputrc" ~
ln -sfhv "$DOTFILES_DIR/editor/.editorconfig" ~
ln -sfhv "$DOTFILES_DIR/git/.gitconfig" ~
ln -sfhv "$DOTFILES_DIR/git/.gitignore_global" ~
ln -sfhv "$DOTFILES_DIR/hg/.hgignore_global" ~
ln -sfhv "$DOTFILES_DIR/curl/.curlrc" ~
ln -sfhv "$DOTFILES_DIR/wget/.wgetrc" ~

ELAPSED_TIME=$(($SECONDS - $START_TIME))

echo ""
echo ""
echo ""
echo "-------------------------"
echo "----- Install ended -----"
echo "-------------------------"
echo "Duration : $(($ELAPSED_TIME/60)) min $(($ELAPSED_TIME%60)) sec"
echo "-------------------------"
