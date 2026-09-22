cask "muster" do
  version "0.4.1"
  arch arm: "aarch64", intel: "x64"

  sha256 arm:   "b2b28922fc2528146389980abe929279205e6f5e2dfd2ae26284587eaa17b3be",
         intel: "85555cb3b49db0bbbfddb0333988969f40617dfa3c29f45dda6d6b35750b9a28"

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
