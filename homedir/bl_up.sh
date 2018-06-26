#!/bin/bash
#set -x
SYSDEV=/sys/class/backlight/backlight

BR=$(cat $SYSDEV/brightness)
MAX=$(cat $SYSDEV/max_brightness)

if [ $BR -lt 5 ]; then
	BR=$((BR + 1))
else
	BR=$((BR + ( BR / 4 )))
fi
if [ $BR -gt $MAX ]; then
	BR=$MAX
fi
echo $BR > $SYSDEV/brightness
