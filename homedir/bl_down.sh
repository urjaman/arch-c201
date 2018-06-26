#!/bin/bash
#set -x
SYSDEV=/sys/class/backlight/backlight
BR=$(cat $SYSDEV/brightness)
if [ $BR -eq 0 ]; then
	exit 0
fi
if [ $BR -lt 5 ]; then
	BR=$((BR - 1))
else
	BR=$((BR - ( BR / 4 )))
fi
echo $BR > $SYSDEV/brightness
