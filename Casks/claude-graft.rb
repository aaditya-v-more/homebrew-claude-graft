cask "claude-graft" do
  version "2.0.1"
  sha256 "62ef14fa9b99e4e805067012aeb3b81b2ca1cc100b23100aa7b74bc3bc330735"

  url "https://github.com/aaditya-v-more/claude-graft/releases/download/v#{version}/ClaudeGraft-#{version}.dmg"
  name "Claude Graft"
  desc "Runs several Claude Desktop accounts side by side and shares their usage"
  homepage "https://graft.aadityamore.com/"

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

  # Homebrew quarantines everything it downloads and, since Homebrew 6, offers
  # no way to ask it not to. The app is ad-hoc signed rather than notarised, so
  # macOS refuses a quarantined copy outright and every user would otherwise
  # have to clear the attribute by hand before the first launch.
  #
  # This is the same thing they would type, done once at install time. It is
  # only reasonable because `brew trust` already asked whether this tap may run
  # its own code, and this is that code, in the open. Nothing else about the
  # app changes: it is still unsigned by Apple, and the caveats still say so.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/Claude Graft.app"],
        must_succeed: false
  end

  # Graft lends logins through a relay that Claude Code reaches by two lines in
  # each borrowing Claude's settings. Removing the app without taking them out
  # would leave Claude Code dialling a relay that is gone after the next
  # logout, so Graft is quit first and its launcher takes the lines out of
  # every Claude that is closed; one that is open loses them as it closes.
  uninstall signal: [["TERM", "graft.claude-graft"]],
            script: {
              executable:   "#{appdir}/Claude Graft.app/Contents/Resources/graft-launch",
              args:         ["--stop-sharing"],
              must_succeed: false,
            }

  # Only what Graft itself wrote. A profile's own folder is named by whoever
  # created it and holds that account's chats, so nothing here goes looking for
  # one to delete.
  zap trash: [
    "~/Library/Application Support/ClaudeGraft",
    "~/Library/Caches/graft.claude-graft",
    "~/Library/HTTPStorages/graft.claude-graft",
    "~/Library/Preferences/graft.claude-graft.plist",
    "~/Library/WebKit/graft.claude-graft",
  ]

  caveats <<~EOS
    Claude Graft is ad-hoc signed rather than notarised, which needs a paid
    Apple developer account. macOS refuses to open a quarantined app that is not
    notarised, and Homebrew quarantines everything it downloads, so this cask
    clears that attribute at install time — the same command you would otherwise
    type yourself, run once, in the open.

    Nothing about the app's signing changes: `spctl` still rejects it, and
    Gatekeeper would still refuse it if the attribute were put back. If you
    would rather make that call yourself, download the release from GitHub
    instead and allow it in System Settings -> Privacy & Security.
  EOS
end
