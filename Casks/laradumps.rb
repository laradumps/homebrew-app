cask "laradumps" do
  version "4.5.0"
  sha256 "f53ddc5661f6db01f38b2e7df84831e6c7ce80d2039f9b2554a58766034622f8"

  url "https://github.com/laradumps/app/releases/download/v#{version}/LaraDumps-#{version}-universal-mac.zip",
      verified: "github.com/laradumps/app/"
  name "LaraDumps"
  desc "🛻 LaraDumps is a friendly app designed to boost your Laravel PHP coding and debugging experience."
  homepage "https://laradumps.dev"

  app "LaraDumps.app"

  zap trash: [
    "~/Library/Application Support/laradumps",
    "~/Library/Preferences/com.laradumps.app.plist",
    "~/Library/Saved Application State/com.laradumps.app.savedState",
  ]
end
