#!/bin/sh 

# yeah this is a giant todo. I still dont know if I'm missing some shit, probably. And plus all of these scripts are hacky since I don't know the proper way of doing things.
#
# But hey, it works :D 

mkdir -p ~/.config

rm -rf ~/.config/sway
rm -rf ~/.config/wofi
rm -rf ~/.config/alacritty
rm -rf ~/.config/mako
rm -rf ~/.config/hypr

rm -rf ~/.config/btop
mkdir -p ~/.config/btop # btop generates a themes folder. We don't want to own the folder. For the other ones, we actually do (sway) or we're lazy (alacritty). 


# For wofi 
mkdir -p ~/.local/bin/gui-apps/
rm -rf ~/.local/bin/gui-apps/*

# Symlink all our favorite things 
# List of applications to symlink
apps="firefox pavucontrol gimp"

# Loop through each app using for loop with word splitting
for app in $apps; do
    # Check if the application is available in the PATH
    if command -v "$app" > /dev/null 2>&1; then
        # Create the symlink if the application is found
        ln -s "$(command -v "$app")" ~/.local/bin/gui-apps/
        echo "Symlinked $app"
    else
        echo "$app not found, skipping."
    fi
done

echo "Done" # :) 
