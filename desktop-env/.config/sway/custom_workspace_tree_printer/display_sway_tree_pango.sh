#!/bin/zsh
# display_sway_tree_pango.sh – Generate a custom workspace tree using Pango markup.
# This replaces ANSI escape codes with Pango markup based on your config mapping.

# WHAT THE FUCK IS THIS 

tilde=~


config_file="${tilde}/.config/sway/custom_workspace_tree_printer/config.json"
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
  
  # Function to escape special characters for Pango markup
  def escape_pango:
    gsub("<"; "&lt;") |
    gsub(">"; "&gt;") |
    gsub("&"; "&amp;") |
    gsub("\""; "&quot;") |
    gsub("'"'"'"; "&apos;");
  
  # Process each output (excluding "__i3") and their workspaces.
  .nodes[] | select(.type == "output" and .name != "__i3") |
  .nodes[] | select(.type == "workspace") as $ws |
  
  # Print the workspace name in cyan.
  ("<span foreground=\"" + pango_colors["white"] + "\">Workspace: " + ($ws.name | escape_pango) + "</span>"),
  
  # Process windows in the workspace.
  ($ws | recurse(.nodes[]?) | select(.type == "con" and .name != null) | 
    if .app_id then
      if $config[0][.app_id] then
        "  <span foreground=\"" + (pango_colors[$config[0][.app_id]]) + "\">" + (.name | escape_pango) + "</span>"
      else
        "  " + (.name | escape_pango)
      end
    elif .window_properties.class then
      if $config[0][.window_properties.class] then
        "  <span foreground=\"" + (pango_colors[$config[0][.window_properties.class]]) + "\">" + (.name | escape_pango) + "</span>"
      else
        "  " + (.name | escape_pango)
      end
    else
      "  " + (.name | escape_pango)
    end
  ),
  
  # Process floating windows.
  ($ws.floating_nodes[]? | select(.type == "con" and .name != null) |
    if .app_id then
      if $config[0][.app_id] then
        "  <span foreground=\"" + (pango_colors[$config[0][.app_id]]) + "\">" + (.name | escape_pango) + "</span> (floating)"
      else
        "  " + (.name | escape_pango) + " (floating)"
      end
    elif .window_properties.class then
      if $config[0][.window_properties.class] then
        "  <span foreground=\"" + (pango_colors[$config[0][.window_properties.class]]) + "\">" + (.name | escape_pango) + "</span> (floating)"
      else
        "  " + (.name | escape_pango) + " (floating)"
      end
    else
      "  " + (.name | escape_pango) + " (floating)"
    end
  )
' <<< "$tree"
