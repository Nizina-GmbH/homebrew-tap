#!/usr/bin/env bash
# Senderos one-line installer (macOS).
#
# One-line free install path on macOS. The user pastes ONE line into Terminal;
# it installs Homebrew if missing, adds the tap, and installs the cask.
#
# F-01 (INTERIM — ad-hoc, no Apple Developer ID yet): the release build is AD-HOC
# signed only, NOT Developer-ID signed or notarized. The cask's postflight strips
# com.apple.quarantine so the app launches (see apps/desktop/homebrew/senderos.rb) —
# without it macOS shows "Senderos is damaged / unidentified developer". The DMG is
# sha256-pinned in the cask, so brew aborts on any mismatch. When a Developer ID
# (signing + notarization) lands, the cask drops the postflight and the app opens
# by double-click with no bypass.
#
# This file is published at:
#   https://raw.githubusercontent.com/Nizina-GmbH/homebrew-tap/main/install-senderos.sh
# so the one-line install is:
#
#   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Nizina-GmbH/homebrew-tap/main/install-senderos.sh)"
#
# NOTE: the tap repo (Nizina-GmbH/homebrew-tap) AND the release repo the cask points
# at (Nizina-GmbH/veyloq-releases) must be PUBLIC — release assets of a private repo
# are not publicly downloadable. See apps/desktop/homebrew/README.md.
set -euo pipefail

# ─── CONFIGURE ────────────────────────────────────────────────────────────────
TAP="Nizina-GmbH/homebrew-tap"   # github.com/Nizina-GmbH/homebrew-tap (must be public)
CASK="senderos"                  # cask token → installs Senderos.app
# ──────────────────────────────────────────────────────────────────────────────

say()  { printf '\033[1;36m→ %s\033[0m\n' "$*"; }
ok()   { printf '\033[1;32m✓ %s\033[0m\n' "$*"; }
die()  { printf '\033[1;31m✗ %s\033[0m\n' "$*" >&2; exit 1; }

[ "$(uname -s)" = "Darwin" ] || die "This installer is for macOS."
case "$(uname -m)" in
  arm64) : ;;
  *) say "Note: this build targets Apple Silicon (arm64); on Intel it will run under Rosetta if at all." ;;
esac

# 1. Homebrew.
if ! command -v brew >/dev/null 2>&1; then
  say "Installing Homebrew (you may be prompted for your password)…"
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  ok "Homebrew already installed."
fi

# Make brew available in THIS shell (Apple Silicon installs to /opt/homebrew).
if ! command -v brew >/dev/null 2>&1; then
  for p in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    [ -x "$p" ] && eval "$("$p" shellenv)" && break
  done
fi
command -v brew >/dev/null 2>&1 || die "Homebrew install did not complete — open a new Terminal and re-run."

# 2. Tap + TRUST. Homebrew 6.0 (June 2026) requires third-party taps to be
#    explicitly trusted before their (arbitrary) Ruby runs — `brew install` from an
#    untrusted tap otherwise refuses/prompts. `|| true` keeps this a no-op on older
#    Homebrew that predates `brew trust`.
say "Adding + trusting the tap…"
brew tap "${TAP}" 2>/dev/null || true
brew trust --cask "${TAP}/${CASK}" 2>/dev/null || true

# 3. Install the signed + notarized cask — no de-quarantine (F-01). A re-run
#    upgrades in place.
say "Installing Senderos…"
brew install --cask "${TAP}/${CASK}"

ok "Senderos installed. Launch it from Applications (or Spotlight)."
echo "  Updates later:  brew upgrade --cask ${CASK}"
echo "  Uninstall:      brew uninstall --cask ${CASK}"
