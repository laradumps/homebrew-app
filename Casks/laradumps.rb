cask "laradumps" do
  version "4.19.2"
  sha256 "a9549e6350d7ea02b6a829c0614a092ac82804e89718bfc6ef792a63fb4cb2f2"

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
