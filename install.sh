#!/usr/bin/env bash
# AIMS installer for macOS.
#   curl -fsSL https://raw.githubusercontent.com/ethan-gobi/AIMS/main/install.sh | bash
# curl downloads are not quarantined by macOS, so this avoids the Gatekeeper
# "unidentified developer" warning. It also clears the flag, makes the binary
# executable, and installs it to your PATH as AIMS.
set -euo pipefail
REPO="ethan-gobi/AIMS"
OS="$(uname -s)"
ARCH="$(uname -m)"
if [ "$OS" != "Darwin" ]; then
  echo "This installer is for macOS. On Windows, download AIMS-windows-x64.exe from:"
  echo "  https://github.com/$REPO/releases/latest"
  exit 1
fi
case "$ARCH" in
  arm64) ASSET="AIMS-macos-arm64" ;;
  x86_64) echo "Intel Mac (x86_64): no x64 build yet - email proffesethgob@gmail.com."; exit 1 ;;
  *) echo "Unsupported architecture: $ARCH"; exit 1 ;;
esac
URL="https://github.com/$REPO/releases/latest/download/$ASSET"
TMP="$(mktemp)"
echo "Downloading AIMS ($ASSET)..."
curl -fSL "$URL" -o "$TMP"
chmod +x "$TMP"
xattr -d com.apple.quarantine "$TMP" 2>/dev/null || true
DEST="/usr/local/bin/AIMS"
echo "Installing to $DEST (you may be prompted for your Mac password)..."
sudo mkdir -p /usr/local/bin
sudo mv "$TMP" "$DEST"
echo ""
echo "Installed. Run it with:  AIMS"
