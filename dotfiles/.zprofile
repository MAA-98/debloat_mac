# ~/.zprofile
#
# This file is read by Z shell (zsh) at the start of a login shell session.
# It sets up the login shell environment, typically environment variables and
# path settings required before interactive or non-interactive shells launch.
#
# On macOS, this is a good place to set up Homebrew environment settings so that
# commands installed by Homebrew are available right away.
#
# Note:
# - This file is NOT sourced by non-login interactive shells.
# - Changes here take effect in new login shell sessions or after running `source ~/.zprofile`.
#

# Updates your environment variables so that you can use Homebrew-installed tools and packages
eval "$(/opt/homebrew/bin/brew shellenv)"
