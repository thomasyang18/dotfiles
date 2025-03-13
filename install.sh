#!/bin/sh

# ---- actual script ----- 

rm -rf build_dir
mkdir build_dir

#!/bin/sh
# Loop through all items in the current directory that end with "-env"
for dir in *-env; do
    # Check if the item is a directory
    if [ -d "$dir" ]; then
        cp -r "$dir"/. build_dir
    fi
done

rm build_dir/install.sh

# ------ NEW - ONLY INSTALL DEV DEPENDENCIES -----
# (UI is still WIP, tons of undocumented dependencies and shit but we ball)

# Check if a "--dev" flag was provided
if [ "$1" = "--dev" ]; then
    if [ -d "developer-env" ]; then
        cd developer-env
        ./install.sh
        cd ..
    else
        echo "developer-env not found!"
    fi
    exit 0
fi

# ------------

for dir in *-env; do
    if [ -d "$dir" ]; then
        cd "$dir"
       	./install.sh	
        cd ..
    fi
done


