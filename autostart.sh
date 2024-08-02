#!/bin/bash

# autostart script for dwm patch

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
    sleep 7
    nextcloud --background &
else
    echo "Nextcloud client is not installed."
fi
