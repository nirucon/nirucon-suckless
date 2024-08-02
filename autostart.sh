#!/bin/bash

# autostart script for dwm patch

# Redirect output to log file
exec >> ~/.dwm/autostart.log 2>&1

# Brief delay to ensure other services are up
sleep 1

# Start xautolock for screen locking after 10 minutes of inactivity
xautolock -time 10 -locker slock &

# Brief delay before starting dunst
sleep 2

# Start dunst for notifications
dunst &

# Set wallpaper using feh
#feh --bg-scale /path/to/your/wallpaper.jpg &

# Start system tray applications
#pasystray &

# Start network manager applet
#nm-applet &

# Start clipboard manager
#copyq &

# Start power management tool
#tlp start &

# Launch frequently used applications
#brave &
#st &

# Start sxhkd for custom keybindings
#sxhkd &

# Brief delay before greeter
sleep 2

# Launch nirucon-greeter
~/.config/nirucon-greeter/greeter &

# Start Nextcloud client if installed
if command -v nextcloud &> /dev/null; then
    sleep 7
    nextcloud --background &
else
    echo "Nextcloud client is not installed."
fi
