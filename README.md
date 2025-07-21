# mac_setup

Short setup scripts for a Mac with factory settings.

---

Script `debloat_mac.sh` does:
- Safely deletes a few default apps (GarageBand, Keynote, Numbers, iMovie)
- Deletes large audio files possibly still around from GarageBand
- Turns down Spotlight to only applications and directories
- Turns off Spotlight Suggestions
- Turns off recent apps in Dock

```shell
xcode-select --install
cd Desktop # or anywhere else you want
git clone https://github.com/MAA-98/mac_setup
cd mac_setup
chmod +x debloat_mac.sh
./debloat_mac.sh
```

---

Script `setup_mac.sh` does:
- Auto-hide Dock and show animation quicker
- copy `/dotfiles/` directory to home directory
- symlinks `.zshrc` and `.zprofile` to home directory.
- creates ~/.my_secrets file and restricts permissions
- deletes the files cloned from `mac_setup` git repo in the first step

In `/mac_setup/`:
```shell
chmod +x setup_mac.sh
./setup_mac.sh
```

The script will automatically restart and hence run `.zshrc`, which notices zsh plugins are missing and clones them from official git repos.

---
### Suggested Next Steps

Download Homebrew from [official repo](https://brew.sh):
```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Add API keys to ~/.my_secrets, login to GitHub and run your private scripts.
