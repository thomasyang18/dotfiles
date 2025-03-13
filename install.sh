#!/bin/sh

mkdir -p ~/.config

# Get the list of *-env directories
env_dirs="$(ls -d *-env)"

# If --dev flag is passed, filter to include only "developer-env"
if [ "$1" = "--dev" ]; then
    env_dirs="developer-env"
fi

# Loop through filtered list of directories
for dir in $(echo $env_dirs); do
	cd "$dir"
	./install.sh
	stow --adopt -v -t ~ . --ignore install.sh --ignore README.md
	cd ..
done
 
