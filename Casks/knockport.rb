cask "knockport" do
  arch arm: "aarch64", intel: "x64"

  version "0.3.3"
  sha256 arm:   "53fff948b0f169dbfde93b128443d8e8385465302ad396745a74a82e2d4f7747",
         intel: "9aaad58e76e0ed4ea27a7a59b0d57a23ca95e3a5b65b66b5647703b40c644622"

  url "https://github.com/WertCore/knockport-releases/releases/download/v#{version}/KnockPort_#{version}_#{arch}.dmg"
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
    KnockPort is not notarized by Apple yet, so macOS refuses to open it after a
    normal install and reports it as "damaged". It is not damaged — that is what
    macOS says about any app it cannot verify.

    Install it without the quarantine flag and the message does not appear:

      brew install --cask --no-quarantine transmitworks/tap/knockport

    If you have already installed it the ordinary way, this clears it:

      xattr -dr com.apple.quarantine "/Applications/KnockPort.app"

    Homebrew applies the quarantine attribute itself, so this cannot be handled
    in the cask — the flag has to come from you.
  EOS
end
