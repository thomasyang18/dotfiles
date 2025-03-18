#!/bin/sh 

# yeah this is a giant todo. I still dont know if I'm missing some shit, probably. And plus all of these scripts are hacky since I don't know the proper way of doing things.
#
# But hey, it works :D 

mkdir ~/.config

rm -rf ~/.config/sway
rm -rf ~/.config/wofi
rm -rf ~/.config/alacritty
rm -rf ~/.config/mako
rm -rf ~/.config/hypr

rm -rf ~/.config/btop
mkdir -p ~/.config/btop # btop generates a themes folder. We don't want to own the folder. For the other ones, we actually do (sway) or we're lazy (alacritty). 

echo "Done" # :) 
