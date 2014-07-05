# pwendok/setup

Commands to run after a fresh install.

1. Configure sys prefs & Finder prefs
2. Make pwendok script executable `$ chmod +x setup/mac*`
3. Setup profile : append `.profile` commands to the user profile.
4. System setup : launch `./mac.setup.sh` to setup & clean the system (the script reboot).
5. App & System Install : launch `./mac.install.sh` to install tools and many apps. Complete the app installations by refering to the `app.md` document.
6. Launch and configure Alfred, then call `$ brew cask alfred link` to link the new cask paths with Alfred.
7. Make a CLI alias to Sublime text : `sudo ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/sublime`
