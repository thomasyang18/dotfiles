#!/bin/zsh
# display_sway_tree_pango.sh – Generate a custom workspace tree using Pango markup.
# This replaces ANSI escape codes with Pango markup based on your config mapping.

config_file="/home/bobbily/.config/sway/custom_workspace_tree_printer/config.json"

if [ ! -f "$config_file" ]; then
  echo "Error: Configuration file '$config_file' not found."
  exit 1
fi

# Capture the Sway tree.
tree=$(swaymsg -t get_tree)

# Process the tree with jq to produce Pango markup.
jq --slurpfile config "$config_file" -r '
  # Define a mapping from color names (from your config) to hex colors.
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

  # Process each output (excluding "__i3") and their workspaces.
  .nodes[] | select(.type == "output" and .name != "__i3") |
  .nodes[] | select(.type == "workspace") as $ws |
  
  # Print the workspace name in cyan.
  ("<span foreground=\"" + pango_colors["cyan"] + "\">Workspace: " + $ws.name + "</span>"),
  
  # Process windows in the workspace.
  ($ws | recurse(.nodes[]?) | select(.type == "con" and .name != null) | 
    if $config[0][.app_id] then
      "  <span foreground=\"" + (pango_colors[$config[0][.app_id]]) + "\">" + .name + "</span>"
    else
      "  " + .name
    end),
  
  # Process floating windows.
  ($ws.floating_nodes[]? | select(.type == "con" and .name != null) |
    if $config[0][.app_id] then
      "  <span foreground=\"" + (pango_colors[$config[0][.app_id]]) + "\">" + .name + "</span> (floating)"
    else
      "  " + .name + " (floating)"
    end)
' <<< "$tree"

