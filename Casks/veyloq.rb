# Homebrew Cask for Veyloq (demo desktop app).
#
# Copy this into the tap repo at Casks/veyloq.rb (github.com/Nizina-GmbH/homebrew-tap).
# The tap AND the release repo it points at are PUBLIC (release assets of a
# private repo aren't publicly downloadable). See README.md in this folder.
#
# Per release, update: version + sha256 (`shasum -a 256 Veyloq-<version>-arm64.dmg`).
# The release repo is Nizina-GmbH/veyloq-releases.
cask "veyloq" do
  version "0.5.56"
  # shasum -a 256 Veyloq-<version>-arm64.dmg  (fill per release)
  sha256 "7532c88f0801c92ddd3e8ab0b8fe4c1484312b14dd6763743efd0be0c59ab183"

  url "https://github.com/Nizina-GmbH/veyloq-releases/releases/download/v#{version}/Veyloq-#{version}-arm64.dmg"
  name "Veyloq"
  desc "AI debugger for vibe-coded iOS/web projects — demo build"
  homepage "https://rebels.ai/"

  depends_on arch: :arm64           # dmg target is arm64-only
  depends_on macos: :ventura        # >= Ventura (13.0); electron-builder minimumSystemVersion

  app "Veyloq.app"

  # Signed with an Apple Developer ID + notarized + stapled (BOTH the .app and the
  # DMG, as of 0.5.46). A notarized app launches by double-click with no Gatekeeper
  # bypass, so there is NO postflight de-quarantine step (0.5.45 and earlier were
  # ad-hoc signed and needed one). The download stays sha256-pinned above (brew
  # aborts on mismatch).

  uninstall quit: "ai.rebels.nizina"

  # First launch unpacks the backend to ~/.nizina/repo and installs system deps;
  # zap removes all of that plus app state.
  zap trash: [
    "~/.nizina",
    "~/Library/Application Support/@nizina/desktop",
    "~/Library/Logs/@nizina/desktop",
    "~/Library/Preferences/ai.rebels.nizina.plist",
    "~/Library/Saved Application State/ai.rebels.nizina.savedState",
  ]
end
