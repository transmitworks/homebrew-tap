cask "knockport" do
  arch arm: "aarch64", intel: "x64"

  version "0.3.7"
  sha256 arm:   "1251651bb039aa8d133e93381249377060482885d8b51655d06acc98fa5aa857",
         intel: "20e676ae6f27efdaa90eece2a9a853113db1af4855f69e9a6304bb7a189d7496"

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
