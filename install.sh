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


for dir in *-env; do
    if [ -d "$dir" ]; then
        cd "$dir"
       	./install.sh	
        cd ..
    fi
done


