#!/bin/sh

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until this script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "----- Install homebrew & cask -----"

sudo ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
sudo brew doctor
sudo brew update
sudo brew upgrade

sudo brew tap phinze/homebrew-cask
sudo brew install brew-cask
sudo brew tap caskroom/versions

echo "----- Install Git, Node & npm with brew -----"

sudo brew install git
sudo brew install mercurial
sudo brew install node
sudo brew install tree
sudo brew install wget
sudo brew install hub

echo "----- Update node.js ----- "

sudo npm install -g n
sudo n stable

echo "----- Install useful global npm packages -----"
sudo npm install -g bower browserify codo coffee-script coffeegulp docco grunt grunt-cli grunt-devtools grunt-init gulp hexo mocha phantomas stylus tankipas vibox vows woazar yo

echo "----- Install applications -----"

sudo brew cask install adobe-creative-cloud
sudo brew cask install alfred
sudo brew cask install atom
sudo brew cask install cleanmymac
sudo brew cask install codekit
sudo brew cask install dropbox
sudo brew cask install droplr
sudo brew cask install fantastical
sudo brew cask install java
sudo brew cask install filebot
sudo brew cask install firefox
sudo brew cask install flux
sudo brew cask install gas-mask
sudo brew cask install github
sudo brew cask install google-chrome
sudo brew cask install hipchat
sudo brew cask install kaleidoscope
sudo brew cask install keyboard-cleaner
sudo brew cask install little-snitch
sudo brew cask install mou
sudo brew cask install onyx
sudo brew cask install paintcode
sudo brew cask install path-finder
sudo brew cask install robomongo
sudo brew cask install sequel-pro
sudo brew cask install sourcetree
sudo brew cask install spotify
sudo brew cask install steam
sudo brew cask install totals
sudo brew cask install tower
sudo brew cask install transmission
sudo brew cask install vlc
sudo brew cask install vagrant
sudo brew cask install versions
sudo brew cask install virtualbox
sudo brew cask install istat-menus
sudo brew cask install iterm2

echo "----- Install useful Quicklook Commands -----"
# https://github.com/sindresorhus/quick-look-plugins
sudo brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql webp-quicklook suspicious-package && qlmanage -r
