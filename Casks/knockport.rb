cask "knockport" do
  arch arm: "aarch64", intel: "x64"

  version "0.4.0"
  sha256 arm:   "7b49b563ad60a182efab06a47b49b8f7c44d32a0a85666f1838c8263691a8b17",
         intel: "cfd4532116a636b0f1ae63cf7a20b49b28c3d65b1e856576597b3203ad91e103"

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
