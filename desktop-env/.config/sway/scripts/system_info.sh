#!/bin/zsh

# The idea is that I will refactor and delete this eventually; I don't likoe the dependency on fastfetch.

# I installed in local bin to not corrupt either. Like, I only need these four things:
# - wifi 
# - brightness
# - volume 
# - battery

# and any other system info i just check with btop lol

# But we will have to see. 
 

# Idempotent double functions as dismissing all 
# Check if there are existing notifications
if [ "$(makoctl list | jq '.data[0] | length')" -gt 0 ]; then
    # Dismiss all notifications
    makoctl dismiss --all
    exit 0
fi
# system_info.sh – Display system information via a Mako notification
# This script collects output from fastfetch, date, ncal, a custom workspace tree printer,
# and the current workspace, then sends it as a formatted, pretty notification.
# Bind this script to a hotkey in sway to view a "terminal" style snapshot of your system info.
bob_home="/home/bobbily"
# Gather fastfetch output.
fastfetch_output="$(
  fastfetch --config "$bob_home/.config/fastfetch/zsh_startup.json" \
            --logo "$bob_home/.config/fastfetch/startup.txt"
)"
# Process fastfetch output:
# Highlight percentages (e.g., 45%) and temperatures (e.g., 23°C or 75°F) in gold,
# while the rest is rendered in sky blue.
fastfetch_output=$(echo "$fastfetch_output" | perl -pe 's/(\d+(?:\.\d+)?%)/<span foreground="#ffd700" weight="bold">$1<\/span>/g')
fastfetch_output=$(echo "$fastfetch_output" | perl -pe 's/(\d+(?:\.\d+)?°[CF])/<span foreground="#ffd700" weight="bold">$1<\/span>/g')
fastfetch_output="<span foreground=\"#87ceeb\">$fastfetch_output</span>"
# Get the current date and make it bold in light green.
date_output="$(date)"
date_output="<span foreground=\"#90ee90\" weight=\"bold\">$date_output</span>"




# Get calendar information using cal instead of ncal
cal_output="$(cal)"
# Get the current day number
current_day=$(date +%-d)
# Highlight the current day in gold and make it bold
cal_output=$(echo "$cal_output" | sed -E "s/\b($current_day)\b/<span foreground=\"#ffd700\" weight=\"bold\">\1<\/span>/g")
# Wrap the calendar output in white
ncal_output="<span foreground=\"#ffffff\">$cal_output</span>"








workspace_name="$(swaymsg -t get_workspaces | jq -r '.[] | select(.focused) | .name')"
# Get the custom workspace tree output from our new Pango-enabled script.
sway_tree_output="$("$bob_home/.config/sway/custom_workspace_tree_printer/display_sway_tree_pango.sh")"
# Now highlight the current workspace in the tree output with a bright color (magenta)
sway_tree_output=$(echo "$sway_tree_output" | sed -E "s/(Workspace: $workspace_name)/<span foreground=\"#d2bc44\" weight=\"bold\">[[\\1]]<\/span>/g")
# Get the current workspace wrapped in orange.
workspace_output="You are on workspace: $workspace_name"
workspace_output="<span foreground=\"#ffa500\" weight=\"bold\">$workspace_output</span>"
# Create a horizontal rule for separation (in grey).
hr="<span foreground=\"#cccccc\">────────────────────</span>"
# Build the full message using Pango markup.


message=""
message+="$fastfetch_output\n"
message+="$hr\n"

message+="$date_output\n"
message+="$hr\n"
message+="$ncal_output\n"
message+="$hr\n"
message+="$sway_tree_output\n"





#message+="$hr\n"

#message+="$workspace_output"
# Send the message as a notification (timeout is 10000ms = 10 seconds).
notify-send -t 600000 "System Information" "$message"
