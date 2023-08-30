#!/bin/sh

chosen=$(find ~/Pictures/wallpapers -type f -printf "%f\n" |
	rofi -dmenu -i -p "Wallpaper:")

if [ -n "$chosen" ]; then
	feh --bg-fill --no-xinerama '/home/adrian/Pictures/wallpapers/'"$chosen"
else
	exit 1
fi
