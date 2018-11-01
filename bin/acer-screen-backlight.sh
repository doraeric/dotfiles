#!/bin/sh
# FileName /etc/acpi/acer-screen-backlight.sh
# Root needed, doesn't work in other path
# This is for screen backlight controlling
# To control backlight through function key,
# use this file with acpi events.

DIR=/sys/class/backlight/intel_backlight

if [ ! -d $DIR ]; then
	>&2 echo $DIR does not exist
	exit 1
fi

# set to 0 will be too dark
MAX=$(cat $DIR/max_brightness)
MIN=$(( MAX / 100 ))
VAL=$(cat $DIR/brightness)
INT=$(( (MAX - MIN) / 15 ))

if [ "$1" = down ]; then
	VAL=$((VAL-INT))
elif [ "$1" = up ]; then
	VAL=$((VAL+INT))
fi

if [ "$VAL" -lt $MIN ]; then
	VAL=$MIN
elif [ "$VAL" -gt $MAX ]; then
	VAL=$MAX
fi

echo $VAL > $DIR/brightness

# To check the event code, run
# `sudo systemctl enable acpid; systemctl status acpid`
# `acpi_listen`
# See https://bbs.archlinux.org/viewtopic.php?id=134972

# # FileName /etc/acpi/events/acer-screen-backlight-down
# # This is called when the user presses the key brightness
# # down button and calls /etc/acpi/acer-screen-backlight.sh for
# # further processing.
#
# event=video/brightnessdown BRTDN 00000087 00000000 K
# action=/etc/acpi/acer-screen-backlight.sh down

# # FileName /etc/acpi/events/acer-screen-backlight-up
# # This is called when the user presses the key brightness
# # up button and calls /etc/acpi/acer-screen-backlight.sh for
# # further processing.
#
# event=video/brightnessup BRTUP 00000086 00000000 K
# action=/etc/acpi/acer-screen-backlight.sh up
