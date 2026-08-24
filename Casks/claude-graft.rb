cask "claude-graft" do
  version "1.0.0"
  sha256 "480253f1e201a6ba8f958d607961813fbbea2f985ec427000f69060366caa326"

  url "https://github.com/aaditya-v-more/claude-graft/releases/download/v#{version}/ClaudeGraft-#{version}.zip",
      verified: "github.com/aaditya-v-more/claude-graft/"
  name "Claude Graft"
  desc "Runs several Claude Desktop logins side by side, sharing chat history"
  homepage "https://github.com/aaditya-v-more/claude-graft"

  livecheck do
    url "https://aaditya-v-more.github.io/claude-graft/appcast.xml"
    strategy :sparkle
  end

  # The app replaces itself through Sparkle, so Homebrew should record the
  # version and then leave upgrades alone rather than reinstalling over the top
  # of a copy that has already moved on.
  auto_updates true
  depends_on macos: :ventura

  app "Claude Graft.app"

  # Only what Graft itself wrote. A profile's own folder is named by whoever
  # created it and holds that account's chats, so nothing here goes looking for
  # one to delete.
  zap trash: [
    "~/Library/Application Support/ClaudeGraft",
    "~/Library/Caches/graft.claude-graft",
    "~/Library/HTTPStorages/graft.claude-graft",
    "~/Library/Preferences/graft.claude-graft.plist",
  ]

  caveats <<~EOS
    Claude Graft is ad-hoc signed rather than notarised, which needs a paid
    Apple developer account, so macOS refuses the first launch. Homebrew always
    quarantines what it downloads and no longer offers a way to skip it, so
    clear it once by hand:

      xattr -dr com.apple.quarantine "/Applications/Claude Graft.app"

    Or launch it, let macOS refuse, then open System Settings -> Privacy &
    Security and choose Open Anyway. Either way it is once: the app updates
    itself from then on, and what it installs is not quarantined.
  EOS
end
