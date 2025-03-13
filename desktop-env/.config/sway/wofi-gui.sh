#!/bin/bash

# kill wofi if it exists 

if pgrep -x wofi >/dev/null 2>&1 && killall wofi; then
    exit 0
fi

# Directory containing symlinked GUI apps
APP_DIR="~/.local/bin/gui-apps"

# List only symlink names (using -maxdepth 1 to avoid recursing)
app_list=$(find "$APP_DIR" -maxdepth 1 -type l -printf "%f\n")

# Check if any apps were found
if [[ -z "$app_list" ]]; then
    echo "No GUI apps found in $APP_DIR" >&2
    exit 1
fi

# Present the list via wofi's dmenu mode; the selected line is output to stdout
selected=$(echo "$app_list" | wofi --dmenu)

# If nothing is selected, exit quietly
if [[ -z "$selected" ]]; then
    exit 0
fi

# Build the full path to the selected symlink
app_path="$APP_DIR/$selected"

# Launch the selected app in a detached process
nohup "$app_path" >/dev/null 2>&1 &

exit 0

