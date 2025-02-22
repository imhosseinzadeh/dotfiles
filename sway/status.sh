#!/bin/bash

# The Sway configuration file in ~/.config/sway/config calls this script.
# You should see changes to the status bar after saving this script.
# If not, do "killall swaybar" and $mod+Shift+c to reload the configuration.

# Emojis and characters for the status bar
UPTIME_EMOJI="⌛"
CPU_EMOJI="🚀"
MEMORY_EMOJI="💾"
VOLUME_EMOJI="🔊"
BLUETOOTH_EMOJI="🔵"
NETWORK_EMOJI="🌐"
IP_EMOJI="📡"
BATTERY_EMOJI="🔋"
PLUGGED_BATTERY_EMOJI="🔌"
DATE_EMOJI="📅"
TIME_EMOJI="🕒"
SEPARATOR="|"

# Get system uptime in a human-readable format
uptime_formatted=$(uptime -p | awk '{print $2"H:"$4"M"}')

# Get battery status (if available)
battery_status="N/A"
if [[ -e /sys/class/power_supply/BAT1/status ]]; then
    battery_status=$(cat /sys/class/power_supply/BAT1/status)
fi

# Get battery status and percentage (if available)
battery_status="N/A"
battery_percentage="N/A"
if [[ -e /sys/class/power_supply/BAT1/status ]] && [[ -e /sys/class/power_supply/BAT1/capacity ]]; then
    battery_status=$(cat /sys/class/power_supply/BAT1/status)
    battery_percentage=$(cat /sys/class/power_supply/BAT1/capacity)
fi

# Check if laptop is connected to electricity and determine the battery emoji to use
battery_emoji=$BATTERY_EMOJI
if [[ "$battery_status" == "Charging" ]]; then
    battery_emoji=$PLUGGED_BATTERY_EMOJI
fi

# Get load average
load_average=$(uptime | awk -F 'load average: ' '{print $2}' | cut -d ',' -f1)

# Get memory usage
mem_usage=$(free -h | awk '/Mem:/ {print $3 "/" $2}')

# Get network status and IP address
network_status=$(ip link show | awk '/state UP/ {print $2}' | tr -d ':')
ip_address=$(hostname -I | awk '{print $1}')

# Get audio volume using wpctl
volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2*100"%"}')

# Get connected Bluetooth device
bluetooth_device=$(bluetoothctl info | grep "Name" | awk -F ': ' '{print $2}')

# Get the current date and time in a formatted string
date_formatted=$(date "+%a %Y-%m-%d")
time_formatted=$(date "+%H:%M")

# Assemble the status bar output
status_bar="$UPTIME_EMOJI $uptime_formatted $SEPARATOR \
$CPU_EMOJI $load_average $SEPARATOR \
$MEMORY_EMOJI $mem_usage $SEPARATOR \
$battery_emoji $battery_status (${battery_percentage}%) $SEPARATOR \
$VOLUME_EMOJI $volume"

# Add Bluetooth device to the status bar if connected
if [[ -n "$bluetooth_device" ]]; then
    status_bar="$status_bar $SEPARATOR $BLUETOOTH_EMOJI $bluetooth_device"
fi

# Continue assembling the status bar output
status_bar="$status_bar $SEPARATOR $NETWORK_EMOJI $network_status $IP_EMOJI $ip_address $SEPARATOR \
$DATE_EMOJI $date_formatted $SEPARATOR $TIME_EMOJI $time_formatted"

# Output the status bar
echo "$status_bar"
