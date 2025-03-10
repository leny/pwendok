#!/bin/sh
# Pwendok Redux -- Install

# VARS
START_TIME=$SECONDS
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo ""
echo "---------- .pwendok --------"
echo ""
echo "This will install & setup all the system."
read -n 1 -r -p "Ready? [y/N]" response
case $response in
    [yY]) echo "";;
    *) exit 1;;
esac

read -e -p "Please enter machine name: " machine_name
MACHINE_NAME=${machine_name:-LenyMachine}

echo ""
echo "----- XCode Command Line Tools -----"

# cf. https://github.com/paulirish/dotfiles/blob/master/setup-a-new-machine.sh#L87

if ! xcode-select --print-path &> /dev/null; then
    xcode-select --install &> /dev/null
    until xcode-select --print-path &> /dev/null; do
        sleep 5
    done
    print_result $? 'Install XCode Command Line Tools'
    sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer
    print_result $? 'Make "xcode-select" developer directory point to Xcode'
    sudo xcodebuild -license
    print_result $? 'Agree with the XCode Command Line Tools licence'
fi

echo ""
echo "----- link dotfiles -----"

ln -sfv "$DOTFILES_DIR/etc/babelrc.json" ~/.babelrc
ln -sfv "$DOTFILES_DIR/etc/curlrc" ~/.curlrc
ln -sfv "$DOTFILES_DIR/etc/editorconfig" ~/.editorconfig
ln -sfv "$DOTFILES_DIR/etc/eslintrc.js" ~/.eslintrc.js
ln -sfv "$DOTFILES_DIR/etc/gitconfig" ~/.gitconfig
ln -sfv "$DOTFILES_DIR/etc/gitignore_global" ~/.gitignore_global
ln -sfv "$DOTFILES_DIR/etc/prettierrc" ~/.prettierrc
ln -sfv "$DOTFILES_DIR/etc/wgetrc" ~/.wgetrc

echo ""
echo "----- link terminfo files -----"

tic -x "$DOTFILES_DIR/etc/terminfo/xterm-256color-italic.terminfo"
tic -x "$DOTFILES_DIR/etc/terminfo/tmux-256color.terminfo"

echo ""
echo "----- install homebrew -----"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew doctor
brew update
brew upgrade

echo "----- brew: install formulas -----"
xargs brew install < "$DOTFILES_DIR/packages/brew"
brew cleanup

echo ""
echo "----- configure neovim -----"

pip3 install --user --upgrade neovim
git clone https://github.com/leny/pweneovim ~/.pweneovim
mkdir -p ~/.config
ln -sfv ~/.pweneovim ~/.config/nvim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qall

echo ""
echo "----- configure & install tmux -----"
mkdir -p ~/.config/tmux-plugins
git clone https://github.com/tmux-plugins/tmux-resurrect ~/.config/tmux-plugins/tmux-resurrect
git clone https://github.com/leny/dotmux.git ~/.dotmux
ln -sfv ~/.dotmux/tmux.conf ~/.tmux.conf

echo ""
echo "----- install fish -----"
rm ~/.config/fish
ln -sfv "$DOTFILES_DIR/fish" ~/.config/fish
FISHPATH=$(brew --prefix)/bin/fish
sudo bash -c 'echo $(brew --prefix)/bin/fish >> /etc/shells'
chsh -s $FISHPATH

echo ""
echo "----- brew: cask -----"
brew tap caskroom/cask
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
xargs brew install --cask < "$DOTFILES_DIR/packages/cask"

echo "----- brew: fonts -----"
brew tap caskroom/fonts
xargs brew cask install < "$DOTFILES_DIR/packages/fonts"

echo ""
echo "----- setup: htop -----"
if [[ "$(type -P $binroot/htop)" ]] && [[ "$(stat -L -f "%Su:%Sg" "$binroot/htop")" != "root:wheel" || ! "$(($(stat -L -f "%DMp" "$binroot/htop") & 4))" ]]; then
    echo "- Updating htop permissions"
    sudo chown root:wheel "$binroot/htop"
    sudo chmod u+s "$binroot/htop"
fi

echo ""
echo "----- install apps from Mac App Store -----"
echo "MAS is disabled on BigSur for now."
# read -e -p "Please enter app store account: " mac_account
# APPLE_ACOUNT=${mac_account}

# mas signin $APPLE_ACOUNT
# mas install 411643860 # DaisyDisk
# mas install 918858936 # Airmail 3
# mas install 419330170 # Moom
# mas install 409183694 # Keynote
# mas install 409201541 # Pages
# mas install 409203825 # Numbers
# mas install 413965349 # Soulver
# mas install 434514810 # Billings Pro
# mas install 435932420 # iPackr
# mas install 497799835 # Xcode
# mas install 498672703 # Droplr
# mas install 531349534 # Tadam
# mas install 536511979 # Characters
# mas install 557168941 # Tweetbot
# mas install 568494494 # Pocket
# mas install 724408341 # Fonts
# mas install 880001334 # Reeder
# mas install 889428659 # xScope
# mas install 904280696 # Things 3
# mas install 937984704 # Amphetamine
# mas install 975937182 # Fantastical 2

echo ""
echo "----- install npm packages -----"
xargs npm install -g < "$DOTFILES_DIR/packages/npm"

echo ""
echo "----- generate directory structure -----"

mkdir -p ~/Works/flatland
mkdir -p ~/Works/leny
mkdir -p ~/Works/mango
mkdir -p ~/Works/misc
mkdir -p ~/Works/resources

echo ""
echo "----- setup mac system -----"

sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################

########## General UI/UX

# Set computer name (as done via System Preferences → Sharing)
sudo scutil --set ComputerName "${MACHINE_NAME}"
sudo scutil --set HostName "${MACHINE_NAME}"
sudo scutil --set LocalHostName "${MACHINE_NAME}"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "${MACHINE_NAME}"

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Disable opening and closing window animations
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable Resume system-wide
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

# Disable the crash reporter
defaults write com.apple.CrashReporter DialogType -string "none"

# Set Help Viewer windows to non-floating mode
defaults write com.apple.helpviewer DevMode -bool true

# Reveal IP address, hostname, OS version, etc. when clicking the clock in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Set language and text formats
defaults write NSGlobalDomain AppleLanguages -array "fr" "en"
defaults write NSGlobalDomain AppleLocale -string "fr_BE@currency=EUR"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

# Set the timezone; see `sudo systemsetup -listtimezones` for other values
sudo systemsetup -settimezone "Europe/Brussels" > /dev/null

######### Terminal (iTerm 2 & Ghostty)

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# Change Terminal Default Theme
open "$DOTFILES_DIR/preferences/leny.terminal"
sleep 1 # Wait a bit to make sure the theme is loaded
defaults write com.apple.terminal "Default Window Settings" -string "leny"
defaults write com.apple.terminal "Startup Window Settings" -string "leny"

# Import iTerm2 settings
defaults import com.googlecode.iterm2 "$DOTFILES_DIR/preferences/com.googlecode.iterm2.plist"

# Disable Spark Updates in MacVim
defaults write org.vim.MacVim SUEnableAutomaticChecks -bool false

# Link the ghostty configuration
ln -sfv "$DOTFILES_DIR/ghostty" ~/.config/ghostty

########## Trackpad, mouse, keyboard, Bluetooth accessories, and input

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Trackpad: swipe between pages with three fingers
defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerHorizSwipeGesture -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 1

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Use scroll gesture with the Ctrl (^) modifier key to zoom
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144
# Follow the keyboard focus while zoomed in
defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Enable access for assistive devices
echo -n 'a' | sudo tee /private/var/db/.AccessibilityAPIEnabled > /dev/null 2>&1
sudo chmod 444 /private/var/db/.AccessibilityAPIEnabled

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

########## Screen

# Save screenshots to the desktop
defaults write com.apple.screencapture location -string "$HOME/Desktop"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# Enable subpixel font rendering on non-Apple LCDs
defaults write NSGlobalDomain AppleFontSmoothing -int 2

########## Finder

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# Always open everything in Finder's list view.
# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Empty Trash securely by default
defaults write com.apple.finder EmptyTrashSecurely -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

# Remove Dropbox’s green checkmark icons in Finder
file=/Applications/Dropbox.app/Contents/Resources/emblem-dropbox-uptodate.icns
[ -e "${file}" ] && mv -f "${file}" "${file}.bak"

# Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
defaults write com.apple.finder FXInfoPanesExpanded -dict General -bool true OpenWith -bool true Privileges -bool true

########## Dock, Dashboard, and hot corners

# Disable bouncing
defaults write com.apple.dock no-bouncing -bool true

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Don’t animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false

# Minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

# Don’t group windows by application in Mission Control (i.e. use the old Exposé behavior instead)
defaults write com.apple.dock expose-group-by-app -bool false

# Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true

# Don’t show Dashboard as a Space
defaults write com.apple.dock dashboard-in-overlay -bool true

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Set the icon size of Dock items to 18 pixels
defaults write com.apple.dock tilesize -int 18

# Dock: disable magnification
defaults write com.apple.dock magnification -bool false

# Show only open applications in the Dock
defaults write com.apple.dock static-only -bool true

# Set magnification icon size to 18 pixels
defaults write com.apple.dock largesize -float 18

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

########## Safari & WebKit

# Set Safari’s home page to `about:blank` for faster loading
defaults write com.apple.Safari HomePage -string "about:blank"

# Remove useless icons from Safari’s bookmarks bar
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

# Set up Safari for development.
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true

# Add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

########## Mail

# Disable send and reply animations in Mail.app
defaults write com.apple.mail DisableReplyAnimations -bool true
defaults write com.apple.mail DisableSendAnimations -bool true

# Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

# Disable inline attachments (just show the icons)
defaults write com.apple.mail DisableInlineAttachmentViewing -bool true

######### Chrome

# Expand the print dialog by default
defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true
defaults write com.google.Chrome.canary PMPrintingExpandedStateForPrint2 -bool true

# Disable the all too sensitive backswipe on Magic Mouse
defaults write com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome.canary AppleEnableMouseSwipeNavigateWithScrolls -bool false

######## Time Machine

# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Menu bar: hide the useless Time Machine and Volume icons
defaults write com.apple.systemuiserver menuExtras -array "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" "/System/Library/CoreServices/Menu Extras/AirPort.menu" "/System/Library/CoreServices/Menu Extras/Battery.menu" "/System/Library/CoreServices/Menu Extras/Clock.menu"

# Disable local Time Machine backups
hash tmutil &> /dev/null && sudo tmutil disablelocal

########## Activity Monitor

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

########## TextEdit and Disk Utility

# Use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit RichText -int 0
# Open and save files as UTF-8 in TextEdit
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

# Enable the debug menu in Disk Utility
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true

########## Mac App Store

# Enable the WebKit Developer Tools in the Mac App Store
defaults write com.apple.appstore WebKitDeveloperExtras -bool true

# Enable Debug Menu in the Mac App Store
defaults write com.apple.appstore ShowDebugMenu -bool true

########## Messages

# Disable smart quotes as it’s annoying for messages that contain code
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false

# Disable continuous spell checking
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false

########## Transmission

# Don't store incomplete downloads aside
defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool false

# Prompt for confirmation before downloading
defaults write org.m0k.transmission DownloadAsk -bool true

# Trash original torrent files
defaults write org.m0k.transmission DeleteOriginalTorrent -bool true

# Hide the donate message
defaults write org.m0k.transmission WarningDonate -bool false
# Hide the legal disclaimer
defaults write org.m0k.transmission WarningLegal -bool false

######### F.lux

# Import F.lux settings
defaults import org.herf.Flux "$DOTFILES_DIR/preferences/org.herf.Flux.plist"

######### Moom

# Import Moom settings
defaults import com.manytricks.Moom "$DOTFILES_DIR/preferences/com.manytricks.Moom.plist"

###############################################################################

ELAPSED_TIME=$(($SECONDS - $START_TIME))

echo ""
echo ""
echo ""
echo "-----------------------------"
echo "----- pwendok ended -----"
echo "-----------------------------"
echo "Duration : $(($ELAPSED_TIME/60)) min $(($ELAPSED_TIME%60)) sec"
echo "-------------------------"
echo "Done. All these changes require a logout/restart to take effect."
echo "-------------------------"

read -n 1 -r -p "Ready? [y/N]" response
case $response in
    [yY]) echo ""; osascript -e 'tell app "System Events" to restart';;
    *) echo "ok."; exit 0;;
esac
