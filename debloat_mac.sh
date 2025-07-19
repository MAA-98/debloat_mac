#!/bin/zsh

# Script for debloating before installing tools:
# - Safely deletes a few default apps
# - Tones down Spotlight to only Applications folder
# - Turns off recent apps in Dock

# Bloatware apps not part of system to be deleted:
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

# Deleting some files for GarageBand and Logic which are large and could be still be around
echo "Removing GarageBand audio content to reclaim space..."
sudo rm -rf "/Library/Application Support/GarageBand"
sudo rm -rf "/Library/Application Support/Logic"
sudo rm -rf "/Library/Audio/Apple Loops"
echo "GarageBand audio content removed."

echo "Deletion process complete."

# Only allow Spotlight to index Applications: I only use it for opening apps
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

# Get rid of recent apps in the Dock
echo "Disabling recent apps in Dock..."
# Set show-recents to false
defaults write com.apple.dock show-recents -bool false
# Restart the Dock to apply changes
killall Dock
echo "Recent apps in Dock have been disabled."
