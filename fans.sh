#! /bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

temp0="/sys/class/drm/card0/device/hwmon/hwmon1/temp1_input"
temp1="/sys/class/drm/card0/device/hwmon/hwmon1/subsystem/hwmon0/temp1_input"
temp2="/sys/class/drm/card0/device/hwmon/hwmon1/subsystem/hwmon0/temp2_input"
pwm="/sys/class/drm/card0/device/hwmon/hwmon1/pwm1"
current=$(cat "$pwm")
while true; do
	next=0
	for temp in "$temp0" "$temp1" "$temp2"; do
		value=$(cat "$temp")
		value=$((value/1000))
		echo -n " $value"
		if [ "$next" -eq 0 ] && [ "$value" -gt 60 ]; then
			next=1
		fi
	done
	echo ""
	if [ "$current" != "$next" ]; then
		if [ "$next" -eq 0 ]; then
			echo "disabling fan"
		else
			echo "enabling fan"
		fi
		echo "$next" > "$fan"
	fi
	current="$next"
	sleep 1s
done