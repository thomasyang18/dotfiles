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

## THIS IS WHY WE MIGHT NEED A BETTER SOLUTION.
# WE DELETE LIKE THIS BECAUSE WE KNOW IN OUR CONFIGS THIS IS NOT GOING TO BE AN OWNED SYMLINK. so delete it. doesnt affect the git repo.
# In the old way, where we deleteed ~/.config/tmux.... if it was already symlinked or some bullshit it would delete tmux.conf. 
# Tons of implicit behavior bugs. 
rm -rf ~/.config/tmux

mkdir -p ~/.config/tmux # prevent stow from symlinking this shit, because ONLY the fact that tmux.conf is there is important, NOT the directory (and this actually matters because tmux will install plugins in this folder... go figure, weird fucking programs

# Neovim  !!! IMPORTANT 

# First, do not install a new neovim if one already exists 
if command -v "neovim" &> /dev/null; then
	# You need sudo permission for this. This is kinda sus....
	curl -L https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz /tmp/nvim.tar.gz 
	sudo rm -rf /opt/nvim
	sudo tar -C /opt -xzf /tmp/nvim.tar.gz
fi
# rm -rf ~/.local/share/nvim # fuck caching
rm -rf ~/.config/nvim # delete the symlink if so 

# notice here how we DO want stow to symlink this, since we want it to manage the whole directory.

# fzf  # [TODO, but either manual install or nixOS OP :D ]

# if command -v "" [TODO maybe add check for on nixos, dont install like this? Although I'm worried it might overwrite my zsh file, this is more controlled.... ]
# to reinstall it 
rm -rf ~/.oh-my-zsh

# fucking dumbass shitter overwriting configs and shit fuck you fuck you fuck you 
yes n | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# no but seriously fuck oh my zsh 

rm  ~/.zshrc

sudo chsh -s $(which zsh) # doesn't work on arch, but whatever. this is why we dont wanna exit on failure :3 chsh is bloat :3 :3 :3 :3 :3
