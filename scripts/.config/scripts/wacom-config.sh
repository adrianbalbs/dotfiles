#!/bin/sh

for i in $(seq 10); do
    if xsetwacom list devices | grep -q Wacom; then
        break
    fi
    sleep 1
done

list=$(xsetwacom list devices)
pad=$(echo "${list}" | awk '/pad/{print $7}')
stylus=$(echo "${list}" | xsetwacom list devices | awk '/stylus/{print $7}')

if [ -z "${pad}" ]; then
    exit 0
fi

# configure the buttons on ${stylus} with your xsetwacom commands...
#xsetwacom set "${stylus}" Button 2 11
#...
xsetwacom  set ${stylus} MapToOutput HEAD-1
xsetwacom set ${stylus} area 0 0 21600 12150
