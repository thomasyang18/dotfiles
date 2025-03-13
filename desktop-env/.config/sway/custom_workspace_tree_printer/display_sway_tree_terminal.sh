#!/bin/zsh

# Path to the configuration file
config_file="/home/bobbily/.config/sway/custom_workspace_tree_printer/config.json"


# Check if the configuration file exists
if [ ! -f "$config_file" ]; then
  echo "Error: Configuration file '$config_file' not found in the current directory."
  exit 1
fi

# Capture the Sway tree
tree=$(swaymsg -t get_tree)

# Process the tree with jq, using the config file for color mapping
jq --slurpfile config "$config_file" -r '
  # Define a color mapping with ANSI escape codes
  def colors: {
    "magenta": "\u001b[35m",
    "orange": "\u001b[33m",  # Using yellow as a stand-in for orange
    "green": "\u001b[32m",
    "blue": "\u001b[34m",
    "red": "\u001b[31m",
    "cyan": "\u001b[36m",
    "yellow": "\u001b[33m",
    "white": "\u001b[37m",
    "black": "\u001b[30m",
    "reset": "\u001b[0m"
  };

  # Process each output (excluding "__i3") and their workspaces
  .nodes[] | select(.type == "output" and .name != "__i3") | 
  .nodes[] | select(.type == "workspace") as $ws |
  
  # Print the workspace name
  "\(colors["cyan"])Workspace: \($ws.name)",
  
  # Find and format windows in the workspace
  ($ws | recurse(.nodes[]?) | select(.type == "con" and .name != null) | 
    if $config[0][.app_id] then
      "  \(colors[$config[0][.app_id]])\(.name)\(colors["reset"])"
    else
      "  \(.name)"
    end),
  
  # Handle floating windows
  ($ws.floating_nodes[]? | select(.type == "con" and .name != null) | 
    if $config[0][.app_id] then
      "  \(colors[$config[0][.app_id]])\(.name)\(colors["reset"]) (floating)"
    else
      "  \(.name) (floating)"
    end)
' <<< "$tree"

