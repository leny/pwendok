#!/bin/sh
# -- Mac Install

START_TIME=$SECONDS

# CWD
DOTFILES_DIR="$( cd "$( dirname "${(%):-%x}" )" && pwd )"

echo ""
echo ""
echo ""
echo "----- Finalize zsh installation -----"

rm ~/.zshrc
rm ~/.zshrc.pre-oh-my-zsh
ln -sfv "$DOTFILES_DIR/zsh/zshrc" ~/.zshrc
ln -sfv "$DOTFILES_DIR/zsh/themes/leny.zsh-theme" ~/.oh-my-zsh/themes/leny.zsh-theme
ln -sfv "$DOTFILES_DIR/zsh/themes/leny-simple.zsh-theme" ~/.oh-my-zsh/themes/leny-simple.zsh-theme
ln -sfv "$DOTFILES_DIR/zsh/themes/leny-powerline.zsh-theme" ~/.oh-my-zsh/themes/leny-powerline.zsh-theme

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
echo "----- Install gems -----"
sudo gem update --system
sudo gem install cocoapods

echo ""
echo ""
echo ""
echo "----- Install homebrew & cask -----"

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor
brew tap caskroom/cask
brew install brew-cask
brew tap caskroom/versions
brew tap caskroom/fonts

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

# dnsmasq
ln -sfv "$DOTFILES_DIR/dnsmasq/dnsmasq.conf" /usr/local/etc/dnsmasq.conf
sudo cp $(brew list dnsmasq | grep /homebrew.mxcl.dnsmasq.plist$) /Library/LaunchDaemons/
sudo launchctl load /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist
sudo mkdir -p /etc/resolver
sudo tee /etc/resolver/dev >/dev/null <<EOF
nameserver 127.0.0.1
EOF
sudo launchctl stop homebrew.mxcl.dnsmasq
sudo launchctl start homebrew.mxcl.dnsmasq

echo ""
echo ""
echo ""
echo "----- Install app's from Cask -----"

export HOMEBREW_CASK_OPTS="--appdir=/Applications"
brew cask install $(cat "$DOTFILES_DIR/Caskfile"|grep -v "#")
qlmanage -r

echo ""
echo ""
echo ""
echo "----- Install app's from AppStore -----"

# using https://github.com/argon/mas
mas install 918858936 # Airmail 2
mas install 937984704 # Amphetamine
mas install 434514810 # Billings Pro
mas install 417896628 # ColorSchemer Studio
mas install 923920635 # Current
mas install 449589707 # Dash
mas install 498672703 # Droplr
mas install 975937182 # Fantastical 2
mas install 724408341 # Fonts
mas install 463541543 # Gemini
mas install 435932420 # iPackr
mas install 409183694 # Keynote
mas install 421131143 # MPlayerX
mas install 419330170 # Moom
mas install 928871589 # Noizio
mas install 409203825 # Numbers
mas install 409201541 # Pages
mas install 568494494 # Pocket
mas install 880001334 # Reeder
mas install 421879749 # Rested
mas install 413965349 # Soulver
mas install 531349534 # Tadam
mas install 557168941 # Tweetbot
mas install 497799835 # Xcode
mas install 889428659 # xScope

echo ""
echo ""
echo ""
echo "----- Install useful global npm packages -----"

npm install -g babel-cli babel-eslint bower browserify coffee-script enpot eslint gadkod grunt grunt-cli gulp hexo mocha phantomas seve stylus stylint tankipas vows watchify woazar yo

echo ""
echo ""
echo ""
echo "----- Install apm packages -----"

apm install package-sync

echo ""
echo ""
echo ""
echo "----- Install python packages -----"

pip install -I Cython==0.23
USE_OSX_FRAMEWORKS=0 pip install kivy
pip install pygments

echo ""
echo ""
echo ""
echo "----- Generate directory structure -----"

mkdir -p ~/Works/flatland
mkdir -p ~/Works/hepl
mkdir -p ~/Works/leny
mkdir -p ~/Works/misc
mkdir -p ~/Works/resources

ELAPSED_TIME=$(($SECONDS - $START_TIME))

echo ""
echo ""
echo ""
echo "-----------------------------"
echo "----- Mac Install ended -----"
echo "-----------------------------"
echo "Duration : $(($ELAPSED_TIME/60)) min $(($ELAPSED_TIME%60)) sec"
echo "-------------------------"
