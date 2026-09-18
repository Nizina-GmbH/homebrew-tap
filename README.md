# Senderos — Homebrew tap

Install **Senderos**, the AI debugger for vibe-coded iOS/web projects (demo build), on macOS (Apple Silicon).

## Install (one line)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Nizina-GmbH/homebrew-tap/main/install-senderos.sh)"
```

Installs Homebrew if missing, adds + trusts this tap, and installs the app. Launch it from Applications or Spotlight.

## Install (if you already have Homebrew)

```bash
brew tap Nizina-GmbH/tap
brew trust --cask Nizina-GmbH/tap/senderos    # Homebrew 6.0+: third-party taps must be trusted
brew install --cask Nizina-GmbH/tap/senderos
```

Update later: `brew upgrade --cask senderos` · Uninstall: `brew uninstall --cask senderos`

## Requirements

- macOS 13 (Ventura) or newer
- Apple Silicon (arm64)

## Note on signing

This build is **ad-hoc signed, not yet Apple-notarized** (Developer ID enrollment pending). The cask's
`postflight` removes the `com.apple.quarantine` attribute so the app launches without the "unidentified
developer" block. The download is **SHA-256-pinned** in the cask, so Homebrew aborts on any mismatch — the
checksum proves the bytes match the cask, not who produced them. When notarization lands, the postflight is
removed and the app opens by a normal double-click with no bypass.

The DMG is hosted at [Nizina-GmbH/veyloq-releases](https://github.com/Nizina-GmbH/veyloq-releases/releases).
