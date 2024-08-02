#!/bin/sh
# If using dwm.desktop
# Place this script in ~/.dwm/ and ensure it's executable

# Start dwm statusbar
~/.config/suckless/bar-dwm/bar_dwm.sh &

# Start compositor
picom -f &

# Restore wallpaper
nitrogen --restore &

# restart dwm
while true; do
	dwm >/dev/null 2>&1
done

# start dwm
exec dwm
