# Homebrew Cask for Senderos (demo desktop app).
#
# Copy this into the tap repo at Casks/senderos.rb (github.com/Nizina-GmbH/homebrew-tap).
# The tap AND the release repo it points at are PUBLIC (release assets of a
# private repo aren't publicly downloadable). See README.md in this folder.
#
# Per release, update: version + sha256 (`shasum -a 256 Senderos-<version>-arm64.dmg`).
# The release repo is Nizina-GmbH/veyloq-releases.
cask "senderos" do
  version "0.5.50"
  # shasum -a 256 Senderos-<version>-arm64.dmg  (fill per release)
  sha256 "216f5410e6bed89c12fed0a2f65ae7c2bcc97db94272a3147e5b4f3e340facf2"

  url "https://github.com/Nizina-GmbH/veyloq-releases/releases/download/v#{version}/Senderos-#{version}-arm64.dmg"
  name "Senderos"
  desc "AI debugger for vibe-coded iOS/web projects — demo build"
  homepage "https://rebels.ai/"

  depends_on arch: :arm64           # dmg target is arm64-only
  depends_on macos: :ventura        # >= Ventura (13.0); electron-builder minimumSystemVersion

  app "Senderos.app"

  # Developer-ID signed + notarized + stapled (app AND dmg): Gatekeeper opens it
  # directly, so no de-quarantine step is needed.

  uninstall quit: "ai.rebels.nizina"

  # First launch unpacks the backend to ~/.nizina/repo and installs system deps;
  # zap removes all of that plus app state.
  zap trash: [
    "~/.nizina",
    "~/Library/Application Support/Senderos",
    "~/Library/Logs/Senderos",
    "~/Library/Preferences/ai.rebels.nizina.plist",
    "~/Library/Saved Application State/ai.rebels.nizina.savedState",
  ]
end
