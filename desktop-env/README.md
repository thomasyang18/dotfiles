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


---

Just ran into the most insane issue with my hardcoded bobbilies and not recognizing "~". Well, now I know that when a script is run in sudo, "\~" changes. 

So that's something. In general though "~" should be safe...??? idk. 

----

Okay mako and wofi just don't run presumably because:

    - mako depends on fastfetch (EWWW), we are removing it NOW!!!
    - wofi has some weird ass file path issues.... idk tho like idk (but also you need to create ~/.local/bin/gui-apps... jesus so many implicit dependencies but this is cleaner I think? idk.)
    

---
also need flashfocus. Install that via pip. Then, on older installations, since ~/.local/bin does not seem to be default in path, we just call it directly in sway config.

Mako no longer depends on fastfetch. However, filetreeprinter still weird.



also need to mkdir ~/.local/bin/gui-apps/ and do manual symlinking.

jq brightnessctl are also dependencies 


okay pactl 13.99 just doenst work. Mayeb I should've stuck with fastfetch lmao...

-----

# OKAY THERES OBVIOUSLY BUGS AND SHIT BUT I THINK THIS FINALLY WORKS. JESUS CHRIST. OKAY. 

## Junko cursor!

Go to webstie, go to ~/.local/share/icons, extract so that directory looks like "Junko/cursors" (so just unzip .). 

Go to /usr/share/icons, change default theme's index to Junko. 

However, this may not work on apps like firefox, because X11 and Wayland moment? IDK. 


## WHAT DID NOT WORK:

- .config/gtk-X/settings.ini. Setting that did not work at all, do not do this. 

# Me from a few days ago being giganticosity 


https://askubuntu.com/questions/1399383/how-to-install-firefox-as-a-traditional-deb-package-without-snap-in-ubuntu-22


Although on my laptop I already had it as a apt package, but from the official ubuntu repo...? Not ppa? IDFK. Im just gonan install mozilla's one thanks

---

Okay this didnt fix cursor issue, but GOOD TO KNOW GOOD TO KNOW!!!. It fixed some issue on my laptop, but ubuntu 20.04 is goated IG. 

---

Okay the braindead solution of just 

```
gsettings set org.gnome.desktop.interface cursor-theme Junko
```

and then also copying that same icon directory globally to /use/share/icons just works. Who knew. Crazy.

---

# WOFI 

More undocumented behavior! cal can be symlinked to ncal, fucking up my display! Yay!

jk on my system its symlinked too, but i think it default calls the -h option. For a portable solution call ncal -b -h. 

----

### !!IMPORTANT 

https://github.com/fennerm/flashfocus/wiki#systemd-config

https://github.com/swaywm/sway/wiki/Systemd-integration


LEARN THIS SHIT THIS IS HOW PROGRAMS SHOULD BE run
unfortunately you have to manually register flashfocus with systemd, but I guess its fine thats more idiomatic we're learning 

uhh... cba to fix this bug right now, fuck this bug. 

---

# HOW TO CONNECT TO WIFI THRU COMMAND LINE 

(using nmcli)

nmcli device wifi list
nmcli device wifi connect "SSID_NAME" password "YOUR_PASSWORD"
nmcli connection show --active

don't forget modprobe, and rfkill, if any weird hardware shit is disabling wifi for some reason
