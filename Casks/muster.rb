cask "muster" do
  version "0.4.3"
  arch arm: "aarch64", intel: "x64"

  sha256 arm:   "67de268befef7d370302060630b569f94f63877554757f8744ac1cf5ea3ff1ae",
         intel: "31ba11406ed3b752965c3d020deaa29219379fe6f5f7c52ff79b175422b80a1a"

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
