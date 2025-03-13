#!/bin/zsh

# Check if there are existing notifications; dismiss if so
if [ "$(makoctl list | jq '.data[0] | length')" -gt 0 ]; then
    makoctl dismiss --all
    exit 0
fi

tilde=~

# Get screen brightness percentage
brightness=$(brightnessctl g)
max_brightness=$(brightnessctl m)
brightness=$(( 100 * brightness / max_brightness ))

# Get battery percentage
battery=$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null || echo "N/A")

# Get audio volume
volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | head -n 1)

# Get WiFi name and signal strength using nmcli (NetworkManager)
wifi_name=$(iw dev | grep -i ssid | awk '{print $2}')
if [ -z "$wifi_name" ]; then
    wifi_output="<span foreground=\"#87ceeb\">WiFi: </span><span foreground=\"#ff4500\" weight=\"bold\">Disconnected</span>"
else
    wifi_output="<span foreground=\"#87ceeb\">WiFi: </span><span foreground=\"#ffd700\">$wifi_name</span>"
fi

# Set battery color (red if <20%)
if [ "$battery" != "N/A" ] && [ "$battery" -lt 20 ]; then
    battery_color="#ff4500"
else
    battery_color="#ffd700"
fi

# Format output
message=""
message+="<span foreground=\"#87ceeb\">Brightness: </span><span foreground=\"#ffd700\">$brightness%</span>\n"
message+="<span foreground=\"#87ceeb\">Battery: </span><span foreground=\"$battery_color\">$battery%</span>\n"
message+="<span foreground=\"#87ceeb\">Audio: </span><span foreground=\"#ffd700\">$volume</span>\n"
message+="$wifi_output\n"

# Okay fastfetch was replaced do other stuff now 


# Get the current date and make it bold in light green.
date_output="$(date)"
date_output="<span foreground=\"#90ee90\" weight=\"bold\">$date_output</span>"


# Get calendar information using cal instead of ncal
cal_output="$(ncal -b -h)"
# Get the current day number
current_day=$(date +%-d)
# Highlight the current day in gold and make it bold
cal_output=$(echo "$cal_output" | sed -E "s/\b($current_day)\b/<span foreground=\"#ffd700\" weight=\"bold\">\1<\/span>/g")
# Wrap the calendar output in white
ncal_output="<span foreground=\"#ffffff\">$cal_output</span>"








workspace_name="$(swaymsg -t get_workspaces | jq -r '.[] | select(.focused) | .name')"
# Get the custom workspace tree output from our new Pango-enabled script.
sway_tree_output="$("${tilde}/.config/sway/custom_workspace_tree_printer/display_sway_tree_pango.sh")"
# Now highlight the current workspace in the tree output with a bright color (magenta)
sway_tree_output=$(echo "$sway_tree_output" | sed -E "s/(Workspace: $workspace_name)/<span foreground=\"#d2bc44\" weight=\"bold\">[[\\1]]<\/span>/g")
# Get the current workspace wrapped in orange.
workspace_output="You are on workspace: $workspace_name"
workspace_output="<span foreground=\"#ffa500\" weight=\"bold\">$workspace_output</span>"
# Create a horizontal rule for separation (in grey).
hr="<span foreground=\"#cccccc\">────────────────────</span>"
# Build the full message using Pango markup.


message+="$hr\n"

message+="$date_output\n"
message+="$hr\n"
message+="$ncal_output\n"
message+="$hr\n"
message+="$sway_tree_output\n"





notify-send -t 60000 "System Stats" "$message"
