# Homebrew tap for OmaZettel

[OmaZettel](https://github.com/mcsmith3/omazettel) is a notes app for a folder
of plain Markdown notes, with `[[wiki links]]`, tags, a dashboard and git sync.
This tap builds it on macOS from the release's source, with Qt and Poppler
from Homebrew.

```sh
brew install mcsmith3/omazettel/omazettel
ln -sf "$(brew --prefix omazettel)/OmaZettel.app" /Applications/OmaZettel.app
```

The second line puts OmaZettel in Applications, so Spotlight and Finder find
it. The `omazettel` command works in a terminal straight away. For exporting
notes to PDF, Word or HTML, also `brew install pandoc`.

**Update:** `brew upgrade omazettel`. **Uninstall:** `brew uninstall omazettel`
(your notes are untouched), then delete `/Applications/OmaZettel.app`.

Already sync your notes from another computer? Clone them and choose that
folder in OmaZettel rather than starting a new one:

```sh
git clone https://github.com/you/notes.git ~/Notes
```

## Releasing

For each OmaZettel release, update `url` and `sha256` in
`Formula/omazettel.rb`:

```sh
v=0.12.0
url="https://github.com/mcsmith3/omazettel/archive/refs/tags/omazettel-v$v.tar.gz"
curl -fsSL "$url" | shasum -a 256
```
