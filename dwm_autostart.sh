#!/bin/sh
# If using login manager and dwm.desktop
# Place this script in ~/.dwm/ and ensure it's executable

# Start xautolock for screen locking after 10 minutes of inactivity
if command -v xautolock &> /dev/null; then
    xautolock -time 10 -locker slock &
else
    echo "xautolock not found. Please install it."
fi

# Start dunst for notifications
if command -v dunst &> /dev/null; then
    dunst &
else
    echo "dunst not found. Please install it."
fi

# Start flameshort if installed
if command -v flameshot &> /dev/null; then
    sleep 0
    flameshot &
else
    echo "flameshot is not installed."
fi

# Brief delay before greeter
sleep 0

# Launch nirucon-greeter
if [ -f ~/.config/nirucon-greeter/greeter ]; then
    ~/.config/nirucon-greeter/greeter &
else
    echo "nirucon-greeter not found."
fi

# Start Nextcloud client if installed
if command -v nextcloud &> /dev/null; then
    sleep 0
    nextcloud --background &
else
    echo "nextcloud client is not installed."
fi

# Start dwm statusbar
~/.config/suckless/nirubar-dwm-arch/nirubar-dwm-arch &

# Start compositor
picom -f &

# Restore wallpaper
feh --randomize --bg-fill ~/Pictures/Wallpapers/* &

# restart dwm
while true; do
	dwm >/dev/null 2>&1
done

# start dwm
exec dwm &

# Start volumeicon if installed
if command -v volumeicon &> /dev/null; then
    sleep 2
    volumeicon 
else
    echo "volumeicon client is not installed."
fi
