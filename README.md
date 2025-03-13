# Setup

## Dev Configs
The developer configs, I understand more than the UI how to install; Plus I'm planning to develop on docker files which means I need a minimal installation. So the developer configs there are preferred; that's where all my tooling and shit goes. 

## Desktop configs

Alacritty, etc. all taht good stuff.

---
# How to set up symlinks 

go to each directory

stow -t ~ -v .

(ignores are set up per each file) 

basically run stow per file lol  

----

ya its a public repo rn. already a docker baby, learning to properly set up ssh keys on top of a possibly broken config no thank you I'ma just stick to my roots. 




----

DOCKER FOLDER SHOULD NOT BE HERE BUT IM ADDING JUST SO ITS EASY TO TRADK


----
# future work 

uhh get ssh keys running, make this private lol 

I think in general I see the vision of devcontainers? I havent' read it too carefully (as usual whenever I'm taking notes) but ideally I'd want some standard always-build things, and then add on top of that. but idk, 


-----
# Current use case 

The dockerfile should just have things and it should just work for building a pretty beefy image 

At the moment you still need to go clone the dotfiles manually though; a consequence of not using devcontainer-cli nor the nvim extension :O it's fine though just clone this repo into the image when you're ready. 

Also not dealing with mounts and volumes yet just gonna keep it simple dont wanna accidetnally brick something  
