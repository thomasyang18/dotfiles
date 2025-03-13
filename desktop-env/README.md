# 3-13-2025 

I don't remember how I instaleld this on my 24.04 laptop; I was just doing shit and hoping it worked. 

But I do have a 20.04 laptop that I'm not **too* worried about bricking (I have a lot of fun files on there but it's not critical...) so will just document this. 

# Install sway 

okay idk why online told me to build from source, arch users. In ubuntu, I just sudo apt install sway, yay get stuff. That's the really nice thing about ubuntu, since it's so big there's just everything on it. 

There's a delicate balance between convenience and bloat. And I think ubuntu is alright on that front. 

It's also far more understandable to precisely document "okay install X Y" instead of "okay build IAHDUIAHSUIDAHUI from source"

---
Though, I might come back to this in a few months/years and cringe, lol. I don't know precisely what's going on, but I do know enough to get a reproducible build, I think. 

```
sudo apt install mako-notifier 
sudo apt install wofi 
sudo apt install alacritty
```

# ! IMPORTANT 

apt install alacritty does not work on 20.04, (already eating my own words lololol), not in the default package repo 

Doesn't even work for 22.04. Wow. 24.04, eh. Got lucky wit it. 

So I'll build this from scratch I guess. 

## Precise Build Process

Needed to install rust (ew), their website has a script as of 3-12-2025 

You can target either x11 or wayland; my old laptop is just gonan run both idrc, there's way too much files in there for me to risk breaking something; I'll roll with both x11 and wayland XD 


    - alacritty is insane 
    - NEED TO ISNTALL JETBRAINS MONO NERD FONT (IT JUST WORKS IN DOCKER THANKFULLY IDK HOW THE UI MAPS UP BUT THANK FULLY IT DOES. BUT FOR THE UI CONFIG... GOTTA INSTALL JETBRAINS MONONERD FONT OR WHATEVER!!!)

    -Installing fonts is easy; just extract zip file, get a bunch of *.ttf files, then extract to ~/.local/share/fonts. Not gonna bother putting that in dotfiles. But it something to keep in mind (perhaps put it in install.sh...? But that would add a dependency on a potentially weird webstie... ugh whatever.)
