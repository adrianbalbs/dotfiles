#! /bin/sh

chosen=$(echo "  Power Off|  Restart|  Suspend|  Hibernate" |
    rofi -sep '|' -dmenu -i -p "Power Options:")

case "$chosen" in
	"  Power Off") poweroff ;;
	"  Restart") reboot ;;
	"  Suspend") systemctl suspend-then-hibernate ;;
	"  Hibernate") systemctl hibernate ;;
	*) exit 1 ;;
esac
