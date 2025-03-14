#!/bin/sh 

set -e

# delete .vimrc .zshrc symlinks

rm -f ~/.vimrc ~/.zshrc


# Uses normal dev stuff like git, curl, tar, etc. please just install it when you build container 
# You should be using this in a dev contianer anyways ,which is fine installing gigabytes of infra y'know? 

# Tmux plugins  !!! IMPORTANT 
# clear cache if we want to re-install
rm -rf ~/.tmux 
mkdir -p ~/.tmux/plugins/tpm 

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

mkdir -p ~/.config/tmux # prevent stow from symlinking this shit, because ONLY the fact that tmux.conf is there is important, NOT the directory (and this actually matters because tmux will install plugins in this folder... go figure, weird fucking programs

rm -rf ~/.config/tmux/* # clear any shitters here 

# Neovim  !!! IMPORTANT 

# You need sudo permission for this. This is kinda sus....
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

rm *.gz

rm -rf ~/.local/share/nvim # fuck caching
rm -rf ~/.config/nvim # delete the symlink if so 

# notice here how we DO want stow to symlink this, since we want it to manage the whole directory.

# fzf 

# to reinstall it 
rm -rf ~/.oh-my-zsh

# fucking dumbass shitter overwriting configs and shit fuck you fuck you fuck you 
yes n | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# no but seriously fuck oh my zsh 

rm  ~/.zshrc

sudo chsh -s $(which zsh)
