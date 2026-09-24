cask "knockport" do
  arch arm: "aarch64", intel: "x64"

  version "0.3.8"
  sha256 arm:   "6c699fc972e46e865608de1de18ada0931783a4b320cf0a8b54f039cb32fadab",
         intel: "38be0e63c29e3a508631da768bcae4c43f398e7ac5da7df5e0d6d504eb0bb4b2"

  url "https://github.com/transmitworks/knockport-releases/releases/download/v#{version}/KnockPort_#{version}_#{arch}.dmg"
  name "KnockPort"
  desc "API client for HTTP, GraphQL, WebSocket, SSE, Socket.IO, MQTT and gRPC"
  homepage "https://knockport.com/"

  # The updater replaces the app in place, so Homebrew is not the only thing
  # that changes this version on disk. Declared so `brew upgrade` does not
  # fight an app that has already updated itself.
  auto_updates true

  depends_on macos: :big_sur

  app "KnockPort.app"

  # `brew uninstall --zap` removes these too. Left out of a plain uninstall on
  # purpose: collections and environments are the user's work, not ours.
  zap trash: [
    "~/Library/Application Support/dev.knockport.desktop",
    "~/Library/Caches/dev.knockport.desktop",
    "~/Library/Preferences/dev.knockport.desktop.plist",
    "~/Library/Saved Application State/dev.knockport.desktop.savedState",
    "~/Library/WebKit/dev.knockport.desktop",
  ]

  caveats <<~EOS
    KnockPort is not notarized by Apple yet, so macOS quarantines it on install
    and reports it as "damaged" on first open. It is not damaged; that is what
    macOS says about any app it cannot verify.

    Homebrew removed the --no-quarantine flag in 6.x, so clear the quarantine
    attribute yourself after installing (once per install):

      xattr -dr com.apple.quarantine "/Applications/KnockPort.app"

    If that reports a permissions error, prefix it with sudo. Then open
    KnockPort normally.
  EOS
end
