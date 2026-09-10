cask "muster" do
  version "0.1.1"
  arch arm: "aarch64", intel: "x64"

  sha256 arm:   "a29b0c651089f7e0f30d9a870e0778e74444d7b0c5e1b36db12d5ac556294fbc",
         intel: "625a1ff73a034968165f01f3ff53b1cefefde2e22008d645862b89dff0340eec"

  url "https://github.com/ronny1020/muster/releases/download/v#{version}/Muster_#{version}_#{arch}.dmg"

  # Without this the cask is invalid on Linux: `arch` resolves to nil there, so
  # `sha256` does too, and `brew tap` refuses the whole tap over it.
  depends_on macos: ">= :catalina"

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
