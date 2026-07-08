#!/usr/bin/env bash
# AIMS installer for macOS (Apple Silicon + Intel).
#   curl -fsSL https://raw.githubusercontent.com/ethan-gobi/AIMS/main/install.sh | bash
#
# What it does:
#   1. Downloads the right binary for your Mac's chip.
#   2. Clears the macOS quarantine flag AND ad-hoc code-signs it, so Gatekeeper
#      doesn't block/kill it (no "unidentified developer" warning, no "killed: 9"
#      on Apple Silicon).
#   3. Installs it to your PATH as `AIMS`.
#   4. Offers to install iTerm2 (AIMS looks broken in the built-in Terminal.app).
#   5. Launches AIMS for you.
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
  arm64)  ASSET="AIMS-macos-arm64" ;;   # Apple Silicon (M1/M2/M3/M4)
  x86_64) ASSET="AIMS-macos-x64"   ;;   # Intel Mac
  *) echo "Unsupported architecture: $ARCH"; exit 1 ;;
esac

URL="https://github.com/$REPO/releases/latest/download/$ASSET"
TMP="$(mktemp)"
echo "==> Downloading AIMS ($ASSET)..."
curl -fSL "$URL" -o "$TMP"
chmod +x "$TMP"

# Clear quarantine + ad-hoc code-sign. Apple Silicon SIGKILLs unsigned binaries
# ("killed: 9"); ad-hoc signing makes the (unsigned-from-CI) binary launchable.
xattr -cr "$TMP" 2>/dev/null || true
codesign --force --sign - "$TMP" 2>/dev/null || true

DEST="/usr/local/bin/AIMS"
echo "==> Installing to $DEST (you may be prompted for your Mac password)..."
sudo mkdir -p /usr/local/bin
sudo mv "$TMP" "$DEST"
sudo chmod +x "$DEST"
echo "==> AIMS installed."

have() { command -v "$1" >/dev/null 2>&1; }
read_tty() { local a=""; [ -r /dev/tty ] && read -r a < /dev/tty || true; echo "$a"; }

# -- iTerm2 --------------------------------------------------------------------
# AIMS renders a true-colour TUI. macOS Terminal.app adds line-spacing and
# quantises colour, so the UI looks broken there. iTerm2 renders it correctly.
ITERM=false
[ -d "/Applications/iTerm.app" ] && ITERM=true

if [ "$ITERM" = false ]; then
  echo ""
  echo "AIMS looks best in iTerm2 — the built-in Terminal.app renders it incorrectly."
  printf "Install iTerm2 now? [Y/n] "
  ANS="$(read_tty)"
  case "${ANS:-y}" in
    n|N) echo "Skipped. Install later with:  brew install --cask iterm2" ;;
    *)
      if ! have brew; then
        echo "==> Installing Homebrew (needed for iTerm2)..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" < /dev/tty || true
        if   [ -x /opt/homebrew/bin/brew ]; then eval "$(/opt/homebrew/bin/brew shellenv)"
        elif [ -x /usr/local/bin/brew   ]; then eval "$(/usr/local/bin/brew shellenv)"; fi
      fi
      if have brew; then
        echo "==> Installing iTerm2..."
        brew install --cask iterm2 || true
        [ -d "/Applications/iTerm.app" ] && ITERM=true
      else
        echo "Couldn't install Homebrew automatically. Get iTerm2 at https://iterm2.com"
      fi
      ;;
  esac
fi

# -- Launch --------------------------------------------------------------------
echo ""
if [ "$ITERM" = true ]; then
  echo "==> Launching AIMS in iTerm2..."
  # (macOS may ask permission for this once — click OK.)
  osascript <<'OSA' 2>/dev/null || echo "Open iTerm2 and run:  AIMS"
tell application "iTerm"
  activate
  set w to (create window with default profile)
  tell current session of w to write text "AIMS"
end tell
OSA
else
  echo "Done. Start AIMS with:  AIMS"
  echo "(For the best-looking UI, run it inside iTerm2.)"
fi
