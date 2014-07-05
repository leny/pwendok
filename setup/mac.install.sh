#!/bin/sh

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until this script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "----- Install homebrew & cask -----"

ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
brew doctor
brew update
brew upgrade

brew tap phinze/homebrew-cask
brew install brew-cask
brew tap caskroom/versions

echo "----- Install Git, Node & npm with brew -----"

brew install git
brew install mercurial
brew install node
brew install tree
brew install wget
brew install hub

echo "----- Update node.js ----- "

sudo npm install -g n
sudo n stable

echo "----- Install useful global npm packages -----"
sudo npm install -g bower browserify codo coffee-script coffeegulp docco grunt grunt-cli grunt-devtools grunt-init gulp hexo mocha phantomas stylus tankipas vibox vows woazar yo

echo "----- Install applications -----"

brew cask install adobe-creative-cloud
brew cask install alfred
brew cask install atom
brew cask install cleanmymac
brew cask install codekit
brew cask install dropbox
brew cask install droplr
brew cask install fantastical
brew cask install java
brew cask install filebot
brew cask install firefox
brew cask install flux
brew cask install gas-mask
brew cask install github
brew cask install google-chrome
brew cask install hipchat
brew cask install kaleidoscope
brew cask install keyboard-cleaner
brew cask install little-snitch
brew cask install mou
brew cask install onyx
brew cask install paintcode
brew cask install path-finder
brew cask install robomongo
brew cask install sequel-pro
brew cask install sourcetree
brew cask install spotify
brew cask install steam
brew cask install totals
brew cask install tower
brew cask install transmission
brew cask install vlc
brew cask install vagrant
brew cask install versions
brew cask install virtualbox
brew cask install istat-menus
brew cask install iterm

echo "----- Install useful Quicklook Commands -----"
# https://github.com/sindresorhus/quick-look-plugins
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql webp-quicklook suspicious-package && qlmanage -r
