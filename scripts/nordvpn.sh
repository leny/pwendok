#!/usr/bin/env bash

# Based on https://bitbucket.org/lars250698/dotfiles/src/1eb4d4051d057315de879bebddfe38d10b0454ac/scripts/.expressstatus.sh?at=master&fileviewer=file-view-default

# Store output of status in tmp
nordvpn status &> /tmp/nordvpn-status

# Fetch the status in to memory
status=$(tr -d '\0' </tmp/nordvpn-status)

if [[ $status = *"Connected"* ]]; then
    echo ""
    exit 0
elif [[ $status = *"Disconnected"* ]]; then
    echo ""
    exit 0
else
    echo ""
    exit 0
fi
exit
