#!/bin/bash
# Installs or reinstalls Crossroads on a Mac. Safe to run again at any time.
#   curl -fsSL https://raw.githubusercontent.com/rjmorales13/crossroads/main/install.sh | bash
set -euo pipefail

REPO="rjmorales13/crossroads"
APP="Crossroads.app"

say() { printf '\n%s\n' "$1"; }
stop() { printf '\nCould not install Crossroads: %s\n' "$1" >&2; exit 1; }

[ "$(uname -s)" = "Darwin" ] || stop "this installer is for Mac only."
ARCH="$(uname -m)"
[ "$ARCH" = "arm64" ] || stop "this Mac has an Intel chip, and Crossroads is built for Apple chips (M1 or newer) for now."

if [ -w /Applications ]; then TARGET="/Applications"; else TARGET="$HOME/Applications"; mkdir -p "$TARGET"; fi
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

say "Downloading Crossroads..."
curl -fL --progress-bar -o "$WORK/app.zip" \
  "https://github.com/$REPO/releases/latest/download/Crossroads-$ARCH.zip" \
  || stop "the download failed. Check your internet connection and run the command again."

/usr/bin/ditto -x -k "$WORK/app.zip" "$WORK/new" || stop "the download was incomplete. Run the command again."
[ -x "$WORK/new/$APP/Contents/MacOS/Crossroads" ] || stop "the download did not contain the app. Run the command again."

say "Installing into $TARGET..."
osascript -e 'tell application "Crossroads" to quit' >/dev/null 2>&1 || true
sleep 1
rm -rf "$TARGET/$APP"
mv "$WORK/new/$APP" "$TARGET/$APP"
xattr -dr com.apple.quarantine "$TARGET/$APP" 2>/dev/null || true

if [ -d "$HOME/Desktop" ] && [ ! -e "$HOME/Desktop/Crossroads" ]; then
  ln -s "$TARGET/$APP" "$HOME/Desktop/Crossroads"
fi

open "$TARGET/$APP"
say "Done. Crossroads is open, and there is a Crossroads icon on your Desktop for next time."
