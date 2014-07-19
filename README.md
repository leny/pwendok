# pwendok

> My dotfiles  
> These are my dotfiles. There are many of them, but those are mine. :)

* * *

**pwendok** is a utility repository to store my dotfiles and other text-based utilities for when, two times a year, I clean my machines and do a *clean install*.

The content of my dotfiles are compiled from my personal experience & from [many places](https://github.com/webpro/awesome-dotfiles) on the web, and the structure of this repo is based on [this article from Lars Kappert](https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789).

## pwendok/setup

Commands to run after a fresh install.

1. Configure sys prefs & Finder prefs
2. Install all the fonts from the NAS.
3. Clone this repo to `~/.pwendok`: `cd && git clone https://github.com/leny/pwendok.git ./.pwendok && cd .pwendok`
4. System setup: launch `source install.sh`, then `source setup.sh` to setup & clean the system (the script reboot).
5. App Install: complete the app installations via the AppStore, and install these :
    * Caffeine
    * ColorSchemer Studio
    * Dash
    * Fonts
    * LiveReload
    * MPlayerX
    * Moom
    * Pocket
    * Reeder
    * Rested
    * Sketch
    * Soulver
    * The Unarchiver
    * Tweetbot
    * Xcode
    * xScope
    * Billings Pro (not on AppStore : [download](https://www.marketcircle.com/billingspro/))
6. Open `leny.itermcolors` & configure iTerm.
7. Launch and configure Alfred, then call `brew cask alfred link` to link the new cask paths with Alfred.
8. Link Sublime Text, Moom configuration from dropbox (warn: read [this article](http://manytricks.com/blog/?p=3049) before).
