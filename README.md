# Homebrew tap for Claude Graft

    brew install --cask aaditya-v-more/claude-graft/claude-graft

[Claude Graft](https://github.com/aaditya-v-more/claude-graft) runs several
Claude Desktop logins side by side, each with its own name, icon and account,
and lets a shortcut read another profile's Claude Code history.

Homebrew asks you to trust the cask the first time, because a tap can run code
of its own at install time and this one is not an official Homebrew tap. Answer
it once and it is remembered by name, so later versions install without asking
again. `brew trust --tap aaditya-v-more/claude-graft` covers anything else added
here later.

## Why the cask clears the quarantine attribute

The app is ad-hoc signed rather than notarised — notarising means a paid Apple
developer account. macOS refuses to open a quarantined app that is not
notarised, and Homebrew quarantines everything it downloads with no way to ask
it not to since Homebrew 6. Without something clearing that attribute, every
install would end with the user running `xattr -dr com.apple.quarantine` by
hand or hunting through System Settings.

So the cask runs that one command in a `postflight`, which is visible in the
cask file and covered by the trust you granted when installing. Nothing about
the app's signature changes; `spctl` still rejects it. If you would rather judge
that yourself, take the zip from the
[releases page](https://github.com/aaditya-v-more/claude-graft/releases) and
allow it in System Settings -> Privacy & Security instead.

The app updates itself through Sparkle afterwards, verifying an EdDSA signature
on every download, so the cask declares `auto_updates` and `brew upgrade` leaves
the installed copy alone.
