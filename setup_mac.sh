#!/bin/zsh

set -e

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
