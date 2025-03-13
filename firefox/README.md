Go to ~/.mozilla/firefox/{profile}

Then put the dotfiles here; for example, chrome can just be symlinked with, well, chrome lul.

Call (from the firefox directory)

stow -v -t ~/.mozilla/firefox/{profile_dir} .
