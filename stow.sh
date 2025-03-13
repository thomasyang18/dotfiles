#!/bin/sh 

# not sure how this works but basically we need to delay writing dot files as long as possible lest we be corrupted by bullshit 

stow --adopt -v -t ~ build_dir/
# git restore . 

