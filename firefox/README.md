Go to ~/.mozilla/firefox/{profile}

Then put the dotfiles here; for example, chrome can just be symlinked with, well, chrome lul.

Call (from the firefox directory)

stow -v -t ~/.mozilla/firefox/{profile_dir}/ .

[ig gnu stow didnt matter lol]

----

For transaparent stuff go into about config and  

browser.tabs.allow_transparent_browser = true 

toolkit.legacyUserProfileCustomizations.stylesheets
