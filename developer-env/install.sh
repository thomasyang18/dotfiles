#!/bin/sh 

set -e

# Uses normal dev stuff like git, curl, tar, etc. please just install it when you build container 
# You should be using this in a dev contianer anyways ,which is fine installing gigabytes of infra y'know? 

# Tmux plugins  !!! IMPORTANT 
# clear cache if we want to re-install
rm -rf ~/.tmux 
mkdir -p ~/.tmux/plugins/tpm 

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Neovim  !!! IMPORTANT 

# You need sudo permission for this. This is kinda sus....
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

rm *.gz

# fzf 

# to reinstall it 
rm -rf ~/.oh-my-zsh

# fucking dumbass shitter overwriting configs and shit fuck you fuck you fuck you 
yes n | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# no but seriously fuck oh my zsh 

rm  ~/.zshrc

sudo chsh -s $(which zsh)
