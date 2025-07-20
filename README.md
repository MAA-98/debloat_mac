# mac_setup

Short setup scripts for a Mac from factory settings.

Initial "debloating":
```shell
xcode-select --install
cd Desktop # or anywhere else you want
git clone https://github.com/MAA-98/mac_setup
cd mac_setup
chmod +x debloat_mac.sh
./debloat_mac.sh
```

Download Homebrew from (official repo)[https://brew.sh]:
```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Copy dotfiles to home dir and symlink the files to home dir. In mac_setup:
```shell
chmod +x setup_mac.sh
./setup_mac.sh
```
