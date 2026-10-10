cask "darktable" do
  arch arm: "arm64"

  version "5.6.2"
  sha256 arm: "6ff88e58a2a59cb07b0a1502fea7205e68cd783380a33a3ce7bda68ec29def0c"

  on_arm do
    depends_on macos: ">= :sonoma"
  end

  url "https://github.com/darktable-org/darktable/releases/download/release-#{version.major_minor_patch}/darktable-#{version}-#{arch}.dmg",
    verified: "github.com/darktable-org/darktable/"
  name "darktable"
  desc "Photography workflow application and raw developer"
  homepage "https://www.darktable.org/"

  livecheck do
    url "https://www.darktable.org/install/"
    regex(/href=.*?darktable[._-]v?(\d+(?:\.\d+)+)[._-]#{arch}\.dmg/i)
  end

  # Upstream disable! date: "2026-09-01", because: :fails_gatekeeper_check

  app "darktable.app"

  postflight do
    system "xattr", "-r", "-d", "com.apple.quarantine", "#{appdir}/darktable.app"
  end

  zap trash: [
    "~/.cache/darktable",
    "~/.config/darktable",
    "~/.local/share/darktable",
    "~/Library/Saved Application State/org.darktable.savedState"
  ]
end
