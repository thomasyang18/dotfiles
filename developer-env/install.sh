#!/bin/sh 

set -e

# Uses normal dev stuff like git, curl, tar, etc. please just install it when you build container 
# You should be using this in a dev contianer anyways ,which is fine installing gigabytes of infra y'know? 

# Tmux plugins  !!! IMPORTANT 
#
mkdir -p ~/.tmux/plugins/tpm 

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Neovim  !!! IMPORTANT 

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
rm -rf /opt/nvim
tar -C /opt -xzf nvim-linux-x86_64.tar.gz

rm *.gz

# fzf 

# fucking dumbass shitter overwriting configs and shit fuck you fuck you fuck you 
yes n | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# no but seriously fuck oh my zsh 

rm  ~/.zshrc

chsh -s $(which zsh)
