# Homebrew tap for Claude Graft

    brew install --cask --no-quarantine aaditya-v-more/claude-graft/claude-graft

[Claude Graft](https://github.com/aaditya-v-more/claude-graft) runs several
Claude Desktop logins side by side, each with its own name, icon and account,
and lets a shortcut read another profile's Claude Code history.

`--no-quarantine` is there because the app is ad-hoc signed rather than
notarised, which needs a paid Apple developer account. Without the flag the
first launch is refused and has to be allowed by hand in System Settings ->
Privacy & Security. Nothing is different about the app either way; the flag only
skips the check macOS runs on downloads.

The app updates itself after that, so the cask declares `auto_updates` and
Homebrew leaves later versions to it. `brew upgrade` will not fight the copy
already installed.
