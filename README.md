# ronny1020/homebrew-tap

Homebrew casks for my own projects.

```bash
brew install --cask ronny1020/tap/muster
xattr -cr /Applications/Muster.app
```

The second line is required. [Muster](https://github.com/ronny1020/muster) is
not notarized — there is no Apple Developer membership behind it — so macOS
refuses to open the copy Homebrew quarantines. Homebrew 6 removed the
`--no-quarantine` flag that used to skip that step.
