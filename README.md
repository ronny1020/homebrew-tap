# ronny1020/homebrew-tap

Homebrew casks for my own projects.

```bash
brew reinstall --cask ronny1020/tap/muster
xattr -cr /Applications/Muster.app
```

`reinstall` installs when nothing is there and repairs when something is, so
these lines work in any state. The second line is required. [Muster](https://github.com/ronny1020/muster) is
not notarized — there is no Apple Developer membership behind it — so macOS
refuses to open the copy Homebrew quarantines. Homebrew 6 removed the
`--no-quarantine` flag that used to skip that step.
