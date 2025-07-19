#!/bin/zsh

BLOAT_APPS=(
  "/Applications/GarageBand.app"
  "/Applications/Keynote.app"
  "/Applications/Numbers.app"
  "/Applications/iMovie.app"
)

for app in "${BLOAT_APPS[@]}"; do
  if [ -d "$app" ]; then
    echo "Deleting $app ..."
    sudo rm -rf "$app"
    if [ $? -eq 0 ]; then
      echo "$app deleted successfully."
    else
      echo "Failed to delete $app."
    fi
  else
    echo "$app not found, skipping."
  fi
done

echo "Deletion process complete."

echo "Disabling Spotlight indexing globally..."
sudo mdutil -a -i off

echo "Enabling Spotlight indexing only for /Applications..."
sudo mdutil -i on /Applications

echo "Adding /Users and /System to Spotlight Privacy (exclude indexing)..."
sudo defaults write /Library/Preferences/com.apple.Spotlight.plist Exclusions -array "/Users" "/System" "/Library" "/private"

echo "Restarting Spotlight indexing daemon..."
sudo killall mds

echo "Done. Spotlight now indexes only /Applications."
mdutil -sa

