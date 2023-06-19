#!/bin/sh

chosen=$(find ~/Pictures/wallpapers -type f -printf "%f\n"|
    rofi -dmenu -i -p "Wallpaper:")

if [ -n "$chosen" ]; then
    feh --no-fehbg --bg-fill '/home/adrian/Pictures/wallpapers/'"$chosen"
    cat >fehbg.sh <<eof
#!/bin/sh
feh --no-fehbg --bg-fill '/home/adrian/Pictures/wallpapers/$chosen'
eof
    chmod u+x fehbg.sh
else
    exit 1
fi
