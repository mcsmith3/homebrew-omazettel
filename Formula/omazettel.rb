# OmaZettel for macOS, built from the release's source with Homebrew's Qt.
# Each release: update url and sha256 (see README.md).
class Omazettel < Formula
  desc "Notes app for a folder of Markdown notes, with wiki links, tags and git sync"
  homepage "https://github.com/mcsmith3/omazettel"
  url "https://github.com/mcsmith3/omazettel/archive/refs/tags/omazettel-v0.12.0.tar.gz"
  sha256 "e2dc1a281f39d23c6da97f90942ea3d80c9441839c0d169ed95d54c503023f14"
  license all_of: ["GPL-3.0-or-later", "MIT"]
  head "https://github.com/mcsmith3/omazettel.git", branch: "master"

  depends_on "pkgconf" => :build
  depends_on :macos
  depends_on "poppler-qt6"
  depends_on "qtbase"
  depends_on "qtdeclarative"
  depends_on "qtsvg"

  def install
    # Homebrew keeps poppler-qt6 out of the usual places, since it clashes
    # with poppler.
    ENV.prepend_path "PKG_CONFIG_PATH", Formula["poppler-qt6"].opt_lib/"pkgconfig"
    system "./bin/build"
    prefix.install "build/OmaZettel.app"
    bin.install_symlink prefix/"OmaZettel.app/Contents/MacOS/OmaZettel" => "omazettel"
  end

  def caveats
    <<~EOS
      To open OmaZettel from Applications, Spotlight and Finder:
        ln -sf #{opt_prefix}/OmaZettel.app /Applications/OmaZettel.app

      Export (PDF, Word, HTML) uses pandoc:
        brew install pandoc

      If your notes already sync from another computer, clone them and choose
      that folder in OmaZettel, rather than starting a new notes folder:
        git clone https://github.com/you/notes.git ~/Notes
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/omazettel --version")
    (testpath/"notes/Plan.md").write "# Plan\n\n- [ ] Ship it\n"
    assert_match "Ship it", shell_output("#{bin}/omazettel tasks --vault #{testpath}/notes --plain")
  end
end
