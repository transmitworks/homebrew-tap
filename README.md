# TransmitWorks Homebrew tap

```sh
brew tap transmitworks/tap
```

## KnockPort

An API client for HTTP, GraphQL, WebSocket, SSE, Socket.IO, MQTT and gRPC.

```sh
brew install --cask --no-quarantine transmitworks/tap/knockport
```

### Why `--no-quarantine`

KnockPort is not notarized by Apple yet. macOS refuses to open an app it cannot
verify and reports it as **"damaged"**, which it is not — that is simply the
message macOS uses.

Homebrew applies the quarantine attribute itself, and a cask cannot opt out of
it, so the flag has to come from you. Installing without it works too; you will
just need to clear the attribute afterwards:

```sh
xattr -dr com.apple.quarantine "/Applications/KnockPort.app"
```

### Uninstalling

```sh
brew uninstall --cask transmitworks/tap/knockport
```

Collections and environments are left alone. To remove those as well:

```sh
brew uninstall --zap --cask transmitworks/tap/knockport
```

## Releases

Casks here track the releases in
[`WertCore/knockport-releases`](https://github.com/WertCore/knockport-releases).
Each version bump is the `version` field plus both `sha256` values — one per
architecture — and they must match the published files exactly, or `brew` will
refuse the download.
