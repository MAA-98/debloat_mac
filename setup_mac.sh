#!/bin/zsh

set -e

# Auto hide Dock, no delay and quick show animation
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.1
killall Dock

DOTFILES_SRC="$(dirname "$0")/dotfiles"
DOTFILES_DEST="$HOME/dotfiles"

# Backup existing dotfiles directory if it exists
if [ -e "$DOTFILES_DEST" ]; then
  echo "Found existing $DOTFILES_DEST"
  TIMESTAMP=$(date +%Y%m%d_%H%M%S)
  BACKUP_DIR="${DOTFILES_DEST}_backup_$TIMESTAMP"
  echo "Moving $DOTFILES_DEST to $BACKUP_DIR"
  mv "$DOTFILES_DEST" "$BACKUP_DIR"
fi

echo "Copying dotfiles from $DOTFILES_SRC to $DOTFILES_DEST ..."
cp -a "$DOTFILES_SRC" "$DOTFILES_DEST"
echo "Copy complete."

echo "Creating symlinks from /dotfiles to home."
# Array of config files to symlink, for now just .zshrc
files=(.zshrc .zprofile)

for file in "${files[@]}"; do
  target="$DOTFILES_DEST/$file"
  link="$HOME/$file"

  # Check if a file or link already exists at the link location
  if [ -e "$link" ] || [ -L "$link" ]; then
	echo "Found existing $link"
	TIMESTAMP=$(date +%Y%m%d_%H%M%S)
	backup_link="${link}_backup_$TIMESTAMP"
    echo "Backing up existing $link to $backup_link"
    mv "$link" "$backup_link"
  fi

  # Create symbolic link
  echo "Creating symlink: $link -> $target"
  ln -s "$target" "$link"
done

echo "Finished creating symlinks."

# Add .my_secrets file and chmod 600
SECRETS_FILE="$HOME/.my_secrets"

if [ ! -e "$SECRETS_FILE" ]; then
  echo "Creating empty $SECRETS_FILE"
  touch "$SECRETS_FILE"
  chmod 600 "$SECRETS_FILE"
else
  echo "$SECRETS_FILE already exists, skipping creation."
fi

# Delete files/directories in the script directory to clean up
cleanup_items=(debloat_mac.sh LICENSE README.md .git .gitignore setup_mac.sh dotfiles)

SCRIPT_DIR="$(dirname "$0")"

for item in "${cleanup_items[@]}"; do
  target="$SCRIPT_DIR/$item"
  if [ -e "$target" ] || [ -L "$target" ]; then
    echo "Removing $target"
    rm -rf "$target"
  fi
done

echo "Restarting your shell to apply changes..."
exec $SHELL -l
