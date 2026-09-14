cask "laradumps" do
  version "4.18.0"
  sha256 "b040874352193bff240cde3ffa850141cac9372f1c7b4477d2dab5e641b7a526"

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
