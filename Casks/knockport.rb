cask "knockport" do
  arch arm: "aarch64", intel: "x64"

  version "0.1.11"
  sha256 arm:   "ab12e0d4b0e7655599200fa458077bb4b7c25393de1229a38de554f963ec32c8",
         intel: "7221e53ee3aae2218bccf8b8a9a8d4e223765578deee10125afaa42243617551"

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
