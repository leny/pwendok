#!/bin/sh

# TODO copy essentials dotfiles to ~

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until this script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# - Install homebrew & cask

ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
brew doctor
brew tap phinze/homebrew-cask
brew install brew-cask
brew tap caskroom/versions

# - Install Git, Node & npm with brew

brew install git
brew install node
brew install tree
brew install wget
brew install hub

# - Install Git, Node & npm with brew

brew install git
brew install node
brew install tree
brew install wget
brew install hub

# Update node

sudo npm install n
sudo n stable

# global npm packages to install
sudo npm install -g bower browserify coffee-script coffeegulp curiosity dalek-cli docco gitbook gitbook-pdf grunt grunt-cli grunt-devtools grunt-init gulp hexo iced-coffee-script mocha phantomas plato stylus vibox vows woazar yo

# - Install applications

# TODO : complete the list

brew cask install alfred
brew cask install dash
brew cask install dropbox
brew cask install firefox
brew cask install google-chrome
brew cask install google-chrome-canary
brew cask install mou
brew cask install sourcetree
brew cask install spotify
brew cask install sublime-text3
brew cask install things
brew cask install tower
brew cask install transmit
brew cask install virtualbox
brew cask install vlc

# Make a CLI alias to Sublime text
sudo ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/sublime

# https://github.com/sindresorhus/quick-look-plugins
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql webp-quicklook suspicious-package && qlmanage -r

# - Update Homebrew, formulae, and packages

brew update
brew upgrade
