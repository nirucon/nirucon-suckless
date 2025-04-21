#!/bin/bash

# Mapp med wallpapers
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# Kolla om mappen finns
[ ! -d "$WALLPAPER_DIR" ] && echo "Wallpaper-mapp saknas." && exit 1

# Intervallet i sekunder (15 minuter)
INTERVAL=900

# Oändlig loop
while true; do
    # Kolla om systemet är aktivt (inte i viloläge)
    if [[ "$(cat /sys/class/power_supply/AC/online 2>/dev/null)" == "1" ]] || [[ "$(cat /proc/acpi/wakeup 2>/dev/null)" ]]; then
        # Slumpa och sätt ny bakgrund
        feh --randomize --bg-fill "$WALLPAPER_DIR"/*
    fi

    # Vänta 15 minuter
    sleep "$INTERVAL"
done
