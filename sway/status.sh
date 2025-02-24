#!/bin/bash

# Emojis and characters for the status bar
CPU_EMOJI="🚀"
CPU_TEMP_EMOJI="🌡️"
MEMORY_EMOJI="💾"
BLUETOOTH_EMOJI="🔵"
WIFI_EMOJI="📶"
BATTERY_EMOJI="🔋"
PLUGGED_EMOJI="🔌"
DATE_EMOJI="📅"
TIME_EMOJI="🕒"
SEPARATOR="|"

# Get load average
load_average=$(uptime | awk -F 'load average: ' '{print $2}' | cut -d ',' -f1)

# CPU Temperature
cpu_temp=$(sensors | awk '/Package id 0:/ {print $4}' | tr -d '+')

# Get memory usage
mem_usage=$(free -h | awk '/Mem:/ {print $3 "/" $2}')

# Get audio volume using wpctl
volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2*100"%"}')

# Set the volume emoji based on volume
if [[ "$volume" == "0%" ]]; then
    volume_emoji="🔇"
    volume="Muted"
else
    volume_emoji="🔊"
    volume="$volume"
fi

# Get connected Bluetooth device
bluetooth_device=$(bluetoothctl info | grep "Name" | awk -F ': ' '{print $2}')

# Wi-Fi Name and Strength
wifi_info=$(nmcli -t -f active,ssid,signal dev wifi | grep '^yes' | cut -d':' -f2,3)
wifi_name=$(echo $wifi_info | cut -d':' -f1)
wifi_strength=$(echo $wifi_info | cut -d':' -f2)

# Power Information
battery_info=$(upower -i $(upower -e | grep 'BAT'))
battery_status=$(echo "$battery_info" | grep 'state' | awk '{print $2}')
battery_percentage=$(echo "$battery_info" | grep 'percentage' | awk '{print $2}')
if [[ "$battery_status" == "discharging" ]]; then
    battery_emoji=$BATTERY_EMOJI
else
    battery_emoji=$PLUGGED_EMOJI
fi

# Get the current date and time in a formatted string
date_formatted=$(date +"%d %b")
time_formatted=$(date "+%H:%M")

# Assemble the status bar output
status_bar="$CPU_EMOJI $load_average $SEPARATOR \
$CPU_TEMP_EMOJI $cpu_temp $SEPARATOR \
$MEMORY_EMOJI $mem_usage $SEPARATOR \
$volume_emoji $volume $SEPARATOR"

# Add wifi information to the status bar if connected
if [[ -n "$wifi_name" ]]; then
    status_bar="$status_bar $WIFI_EMOJI $wifi_name ($wifi_strength%) $SEPARATOR"
fi

# Add Bluetooth device to the status bar if connected
if [[ -n "$bluetooth_device" ]]; then
    status_bar="$status_bar $SEPARATOR $BLUETOOTH_EMOJI $bluetooth_device"
fi

# Continue assembling the status bar output
status_bar="$status_bar \
$battery_emoji $battery_status (${battery_percentage}) $SEPARATOR \
$DATE_EMOJI $date_formatted $SEPARATOR $TIME_EMOJI $time_formatted"

# Output the status bar
echo "$status_bar"
