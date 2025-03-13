#!/bin/sh


# Hack to get dev enviornment working. You REALLY SHOULD'VE INSTALLED ALL OF THIS!!! (okay zsh is easy to forget but )
#

#apt update -y && apt install vim git -y # lol okay  

apt update -y && apt install curl tar zsh -y


# ---- actual script ----- 

apt update -y && apt install stow -y

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


