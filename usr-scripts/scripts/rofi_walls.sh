#!/bin/sh

chosen=$(find ~/Pictures/wallpapers -type f -printf "%f\n"|
    rofi -dmenu -i -p "Wallpaper:")

if [ -n "$chosen" ]; then
    feh --bg-fill '/home/adrian/Pictures/wallpapers/'"$chosen" 
else
    exit 1
fi
