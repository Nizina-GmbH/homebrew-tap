# Veyloq — Homebrew tap

Install **Veyloq**, the AI debugger for vibe-coded iOS/web projects (demo build), on macOS (Apple Silicon).

## Install (one line)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Nizina-GmbH/homebrew-tap/main/install-veyloq.sh)"
```

Installs Homebrew if missing, adds + trusts this tap, and installs the app. Launch it from Applications or Spotlight.

## Install (if you already have Homebrew)

```bash
brew tap Nizina-GmbH/tap
brew trust --cask Nizina-GmbH/tap/veyloq    # Homebrew 6.0+: third-party taps must be trusted
brew install --cask Nizina-GmbH/tap/veyloq
```

Update later: `brew upgrade --cask veyloq` · Uninstall: `brew uninstall --cask veyloq`

Previously installed as `senderos`? `brew update && brew upgrade --cask senderos` migrates you to `veyloq`
automatically (see `cask_renames.json`).

## Requirements

- macOS 13 (Ventura) or newer
- Apple Silicon (arm64)

## Signing

Signed with an Apple Developer ID, notarized and stapled — it opens by double-click with no Gatekeeper workaround.
