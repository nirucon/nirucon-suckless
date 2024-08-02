# .xinitrc by Nicklas Rudolfsson for my Arch Linux setup
# https://github.com/nirucon

# Set keyboard layout to Swedish
setxkbmap se &

# Start nirubar-dwm-*


#~/.config/suckless/nirubar-dwm/nirubar-dwm &

# Start compositor
picom -f &

# Set default GTK and Icon themes

# Set QT5 theme
#export QT_QPA_PLATFORMTHEME="qt5ct"

# Set QT6 theme
export QT_QPA_PLATFORMTHEME="qt6ct"

# Restore wallpaper
#nitrogen --restore &

# Nitrogen set nirucon wallpaper
nitrogen --set-zoom-fill ~/Pictures/nirucon-wallpapers/nirucon-death-3840x2160.jpg &

# Restart dwm in case of reload or crash + log
while true; do
    /usr/local/bin/dwm 2>/tmp/dwm.log
done

# Start dwm - not needed when using restart above
#exec dwm
