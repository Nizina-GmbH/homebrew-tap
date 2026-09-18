# Homebrew Cask for Senderos (demo desktop app).
#
# Copy this into the tap repo at Casks/senderos.rb (github.com/Nizina-GmbH/homebrew-tap).
# The tap AND the release repo it points at are PUBLIC (release assets of a
# private repo aren't publicly downloadable). See README.md in this folder.
#
# Per release, update: version + sha256 (`shasum -a 256 Senderos-<version>-arm64.dmg`).
# The release repo is Nizina-GmbH/veyloq-releases.
cask "senderos" do
  version "0.5.42"
  # shasum -a 256 Senderos-<version>-arm64.dmg  (fill per release)
  sha256 "86701e7cecce906a7f5ffa015a77214722b69c59700e5ce3c3790a11eb921ab8"

  url "https://github.com/Nizina-GmbH/veyloq-releases/releases/download/v#{version}/Senderos-#{version}-arm64.dmg",
      verified: "github.com/Nizina-GmbH/veyloq-releases/"
  name "Senderos"
  desc "AI debugger for vibe-coded iOS/web projects — demo build"
  homepage "https://rebels.ai"

  depends_on macos: ">= :ventura"   # electron-builder minimumSystemVersion 13.0
  depends_on arch: :arm64           # dmg target is arm64-only

  app "Senderos.app"

  # F-01 (INTERIM — ad-hoc, no Apple Developer ID yet):
  # This build is AD-HOC signed only (codesign -s -), NOT Developer-ID signed or
  # notarized. macOS quarantines any cask download, and Gatekeeper blocks an
  # un-notarized app → without help the user hits "Senderos is damaged / from an
  # unidentified developer" and it won't open. The postflight below strips
  # com.apple.quarantine so the ad-hoc app launches. Homebrew 6.0 gates a tap's
  # arbitrary postflight code behind `brew trust --cask` (the installer runs it).
  #
  # SECURITY TRADE-OFF: de-quarantine bypasses Gatekeeper's notarization check, so
  # a substituted DMG would run unchecked. It is acceptable ONLY because the tap +
  # release repo are ours and the download is sha256-pinned above (brew aborts on
  # mismatch). When a Developer ID (signing + notarization + staple) lands, DELETE
  # this postflight — a notarized app launches by double-click with no bypass.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Senderos.app"]
  end

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
