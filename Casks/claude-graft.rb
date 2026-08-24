cask "claude-graft" do
  version "1.0.0"
  sha256 "480253f1e201a6ba8f958d607961813fbbea2f985ec427000f69060366caa326"

  url "https://github.com/aaditya-v-more/claude-graft/releases/download/v#{version}/ClaudeGraft-#{version}.zip",
      verified: "github.com/aaditya-v-more/claude-graft/"
  name "Claude Graft"
  desc "Runs several Claude Desktop logins side by side and shares chat history between them"
  homepage "https://github.com/aaditya-v-more/claude-graft"

  livecheck do
    url "https://aaditya-v-more.github.io/claude-graft/appcast.xml"
    strategy :sparkle
  end

  # The app replaces itself through Sparkle, so Homebrew should record the
  # version and then leave upgrades alone rather than reinstalling over the top
  # of a copy that has already moved on.
  auto_updates true
  depends_on macos: ">= :ventura"

  app "Claude Graft.app"

  # Only what Graft itself wrote. A profile's own folder is named by whoever
  # created it and holds that account's chats, so nothing here goes looking for
  # one to delete.
  zap trash: [
    "~/Library/Application Support/ClaudeGraft",
    "~/Library/Caches/graft.claude-graft",
    "~/Library/Preferences/graft.claude-graft.plist",
    "~/Library/HTTPStorages/graft.claude-graft",
  ]

  caveats <<~EOS
    Claude Graft is signed but not notarised, so macOS blocks it on first launch
    unless it was installed with --no-quarantine:

      brew install --cask --no-quarantine aaditya-v-more/claude-graft/claude-graft

    Without that flag, open System Settings -> Privacy & Security after the
    first launch attempt and choose Open Anyway. Updates the app installs itself
    afterwards need no such step.
  EOS
end
