# mac_setup

Short setup scripts for a Mac with factory settings.

Initial "debloating":
```shell
xcode-select --install
cd Desktop # or anywhere else you want
git clone https://github.com/MAA-98/mac_setup
cd mac_setup
chmod +x debloat_mac.sh
./debloat_mac.sh
```

Download Homebrew from [official repo](https://brew.sh):
```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Script `setup_mac.sh` does:
- copy `/dotfiles/` to home directory
- symlinks `.zshrc` and `.zprofile` to home directory. 
- installs `neovim` and `tmux` <~~ TODO

In `/mac_setup/`:
```shell
chmod +x setup_mac.sh
./setup_mac.sh
```

The script will automatically restart and hence run `.zshrc`, which notices zsh plugins are missing and clones them from git.
