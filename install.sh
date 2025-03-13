#!/bin/sh

mkdir -p ~/.config

# Get the list of *-env directories
env_dirs=(*-env)

# If --dev flag is passed, filter to include only "developer-env"
if [ "$1" == "--dev" ]; then
    env_dirs=("developer-env")
fi

# Loop through filtered list of directories
for dir in "${env_dirs[@]}"; do
    if [ -d "$dir" ]; then
        cd "$dir"
        echo "install.sh" > .stow-local.ignore
        ./install.sh
        stow --adopt -v -t ~ .
    fi
done
