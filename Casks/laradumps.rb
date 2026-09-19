cask "laradumps" do
  version "4.18.1"
  sha256 "0f9118fd6cc1cfd54adf3769d5466893004275c1b28f69774626554ae1d841a4"

  url "https://github.com/laradumps/app/releases/download/v#{version}/LaraDumps-#{version}-universal-mac.zip"
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
