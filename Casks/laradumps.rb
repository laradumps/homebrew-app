cask "laradumps" do
  version "4.10.0"
  sha256 "6695bdd575c8f52a6d63e60f76cf73517ae9a1caf86aed7af028379a2ed3f92d"

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
