#!/usr/bin/env zsh
# display_hyprland_tree_pango.sh - Generate a custom workspace tree with Pango markup for Hyprland

# Setup path to config file
CONFIG_FILE="$HOME/.config/mako/workspace_tree_config.json"

if [ ! -f "$CONFIG_FILE" ]; then
  echo "Error: Configuration file '$CONFIG_FILE' not found."
  exit 1
fi

# Capture Hyprland workspaces and clients information
workspaces=$(hyprctl -j workspaces)
clients=$(hyprctl -j clients)

# Process with jq - added sorting for workspaces
jq -r --slurpfile config "$CONFIG_FILE" -n --argjson workspaces "$workspaces" --argjson clients "$clients" '
# Define color mapping
def pango_colors: {
  "magenta": "#ff00ff",
  "orange": "#ffa500",
  "green": "#008000",
  "blue": "#0000ff",
  "red": "#ff0000",
  "cyan": "#00ffff",
  "yellow": "#ffff00",
  "white": "#ffffff",
  "black": "#000000"
};

# Function to escape special characters for Pango markup
def escape_pango:
  gsub("<"; "&lt;") |
  gsub(">"; "&gt;") |
  gsub("&"; "&amp;") |
  gsub("\""; "&quot;") |
  gsub("'\''"; "&apos;");

# Sort workspaces numerically by name
# First convert name to number for numeric sorting
($workspaces | sort_by(
  # Try to convert name to number, fallback to 999 if not numeric
  (.name | tonumber? // 999)
)) as $sorted_workspaces |

# Process each workspace in sorted order
$sorted_workspaces[] | . as $ws | 
  # Print workspace header
  "<span foreground=\"" + pango_colors["white"] + "\">Workspace: " + ($ws.name | tostring | escape_pango) + "</span>",
  
  # Process each client in this workspace
  ($clients[] | select(.workspace.id == $ws.id) | 
    # Determine the app identifier
    (if .class then .class 
     elif .initialClass then .initialClass 
     else .initialTitle end) as $app_id |
    
    # Get color from config if available
    (if $config[0][$app_id] then pango_colors[$config[0][$app_id]] else pango_colors["white"] end) as $color |
    
    # Format output with color and floating indicator
    "  <span foreground=\"" + $color + "\">" + (.title | escape_pango) + 
    (if .floating then " (floating)" else "" end) + "</span>"
  )
'
