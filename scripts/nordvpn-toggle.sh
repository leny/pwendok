#!/usr/bin/env bash

# Store output of status in tmp
nordvpn status &> /tmp/nordvpn-status

# Fetch the status in to memory
status=$(tr -d '\0' </tmp/nordvpn-status)

if [[ $status = *"Disconnected"* ]]; then
    nordvpn connect belgium
else
    nordvpn disconnect
fi
