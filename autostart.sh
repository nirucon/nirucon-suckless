#!/bin/bash

# autostart script for dwm patch made for my arch, void and debian setup

# Redirect output to log file
exec >> ~/.dwm/autostart.log 2>&1

# Brief delay to ensure other services are up
sleep 1

# Start xautolock for screen locking after 10 minutes of inactivity
if command -v xautolock &> /dev/null; then
    xautolock -time 10 -locker slock &
else
    echo "xautolock not found. Please install it."
fi

# Brief delay before starting dunst
sleep 2

# Start dunst for notifications
if command -v dunst &> /dev/null; then
    dunst &
else
    echo "dunst not found. Please install it."
fi

# Start PipeWire on Void Linux if installed
if grep -q "Void" /etc/os-release && command -v pipewire &> /dev/null; then
    pipewire &
    pipewire-pulse &
    wireplumber &
else
    echo "PipeWire not found or not on Void Linux."
fi

# Start volumeicon if installed
if command -v volumeicon &> /dev/null; then
    sleep 1
    volumeicon &
else
    echo "volumeicon client is not installed."
fi

# Start flameshort if installed
if command -v flameshot &> /dev/null; then
    sleep 1
    flameshot &
else
    echo "flameshot is not installed."
fi

# Brief delay before greeter
sleep 2

# Launch nirucon-greeter
if [ -f ~/.config/nirucon-greeter/greeter ]; then
    ~/.config/nirucon-greeter/greeter &
else
    echo "nirucon-greeter not found."
fi

# Start Nextcloud client if installed
if command -v nextcloud &> /dev/null; then
    sleep 4
    nextcloud --background &
else
    echo "nextcloud client is not installed."
fi
