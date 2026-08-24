# Homebrew tap for Claude Graft

    brew install --cask aaditya-v-more/claude-graft/claude-graft
    xattr -dr com.apple.quarantine "/Applications/Claude Graft.app"

[Claude Graft](https://github.com/aaditya-v-more/claude-graft) runs several
Claude Desktop logins side by side, each with its own name, icon and account,
and lets a shortcut read another profile's Claude Code history.

The second line is there because the app is ad-hoc signed rather than notarised,
and notarising needs a paid Apple developer account. Homebrew quarantines
everything it downloads — Homebrew 6 dropped the `--no-quarantine` flag that
used to skip it — so macOS refuses the first launch until the attribute is
cleared. Opening System Settings -> Privacy & Security and choosing Open Anyway
after the refusal does the same thing.

It is a one-time step either way. The app updates itself through Sparkle after
that, and Sparkle clears the attribute on what it installs, so no later version
asks again. The cask declares `auto_updates`, so `brew upgrade` leaves the
installed copy alone rather than reinstalling over a version that has already
moved on.
