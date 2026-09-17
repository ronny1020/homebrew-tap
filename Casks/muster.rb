cask "muster" do
  version "0.3.0"
  arch arm: "aarch64", intel: "x64"

  sha256 arm:   "9647d9209215cac31ceed29e5d6a8cf587f243638ff816d54a06dae9768e20ae",
         intel: "9cbd4edd966fb336466b25c45d2d614362f233760b2712fd1904b2ffdd5370ed"

  url "https://github.com/ronny1020/muster/releases/download/v#{version}/Muster_#{version}_#{arch}.dmg"

  # Without this the cask is invalid on Linux: `arch` resolves to nil there, so
  # `sha256` does too, and `brew tap` refuses the whole tap over it. A bare
  # `:macos` is the only accepted form — Homebrew 6 disabled the versioned
  # `depends_on macos:` with no replacement.
  depends_on :macos

  name "Muster"
  desc "Run AI agent CLIs in tabs, each a real terminal with its own git state"
  homepage "https://github.com/ronny1020/muster"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "Muster.app"

  # Not notarized, and Homebrew 6 removed `--no-quarantine`, so the attribute
  # has to come off after installing or macOS refuses to open the app.
  caveats <<~CAVEATS
    Muster is not notarized. Clear the quarantine attribute before opening it:

      xattr -cr #{appdir}/Muster.app
  CAVEATS

  zap trash: [
    "~/Library/Application Support/io.github.ronny1020.muster",
    "~/Library/Caches/io.github.ronny1020.muster",
    "~/Library/Preferences/io.github.ronny1020.muster.plist",
    "~/Library/WebKit/io.github.ronny1020.muster",
  ]
end
