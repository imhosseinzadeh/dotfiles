#!/bin/bash

# Emojis and characters for the status bar
CPU_EMOJI="🚀"
CPU_TEMP_EMOJI="🌡️"
MEMORY_EMOJI="💾"
WIFI_EMOJI="📶"
UPTIME_EMOJI="⏱️"
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

# Wi-Fi Name and Strength
wifi_info=$(nmcli -t -f active,ssid,signal dev wifi | grep '^yes' | cut -d':' -f2,3)
if [[ -n "$wifi_info" ]]; then
    wifi_name=$(echo $wifi_info | cut -d':' -f1)
    wifi_strength=$(echo $wifi_info | cut -d':' -f2)
    wifi_strength="${wifi_strength}%"
else
    wifi_name="Disconnected"
    wifi_strength="N/A"
fi

# Get the system uptime in a shortened format (1d 2h 30m)
uptime_raw=$(uptime -p | sed 's/up //')

# Shorten the uptime format
uptime_short=""
if echo "$uptime_raw" | grep -q "day"; then
    days=$(echo "$uptime_raw" | grep -o '[0-9]* day' | sed 's/ day/d/')
    uptime_short+="$days "
fi
if echo "$uptime_raw" | grep -q "hour"; then
    hours=$(echo "$uptime_raw" | grep -o '[0-9]* hour' | sed 's/ hour/h/')
    uptime_short+="$hours "
fi
if echo "$uptime_raw" | grep -q "minute"; then
    minutes=$(echo "$uptime_raw" | grep -o '[0-9]* minute' | sed 's/ minute/m/')
    uptime_short+="$minutes"
fi

uptime_short="${uptime_short:-N/A}"

# Get the current date and time in a formatted string
date_formatted=$(date +"%d %b")
time_formatted=$(date "+%H:%M")

# Assemble the status bar output
status_bar="$CPU_EMOJI $load_average $SEPARATOR \
$CPU_TEMP_EMOJI $cpu_temp $SEPARATOR \
$MEMORY_EMOJI $mem_usage $SEPARATOR \
$volume_emoji $volume $SEPARATOR"

status_bar="$status_bar $WIFI_EMOJI $wifi_name ($wifi_strength) $SEPARATOR"

# Add uptime to the status bar
status_bar="$status_bar $UPTIME_EMOJI $uptime_short $SEPARATOR"

# Continue assembling the status bar output
status_bar="$status_bar \
$DATE_EMOJI $date_formatted $SEPARATOR $TIME_EMOJI $time_formatted"

# Output the status bar
echo "$status_bar"
