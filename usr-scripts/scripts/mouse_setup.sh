#!/bin/sh

mx_master=$(xinput list |
            grep -E '(Logitech MX Master 3).*pointer'|
            cut -f2 |
            cut -d'=' -f2)


superlight=$(xinput list |
    grep -E '(Logitech USB Receiver) [^(Keyboard)].*pointer'|
            cut -f2 |
            cut -d'=' -f2)

if [ -n "$mx_master" ]; then
    xinput --set-prop "$mx_master" "libinput Accel Speed" -0.5 &
    xinput --set-prop "$mx_master" "libinput Accel Profile Enabled" 0, 1 &
fi

if [ -n "$superlight" ]; then
    xinput --set-prop "$superlight" "libinput Accel Speed" -0.5 &
    xinput --set-prop "$superlight" "libinput Accel Profile Enabled" 0, 1 &
fi
