# typed: strict
# frozen_string_literal: true

cask "ai-pause" do
  version "0.3.1"
  sha256 "d3a8c4e6138323963f05fd1363ba1d9a69876700077ed2f8daa18fa73b8695ab"

  url "https://github.com/philipparndt/ai-pause/releases/download/v#{version}/AI-Pause-#{version}.zip"
  name "AI Pause"
  desc "Menu bar app that pauses AI coding agents during calls and games"
  homepage "https://github.com/philipparndt/ai-pause"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "AI Pause.app"
  binary "#{appdir}/AI Pause.app/Contents/MacOS/ai-pause"

  # Homebrew runs these on upgrades too. Quitting exits cleanly, so launchd keeps the
  # login item loaded without restarting it, and kickstart starts the new version.
  # Without a login item, kickstart fails and nothing starts.
  uninstall quit: "de.philipparndt.ai-pause"

  postflight_steps do
    run "/bin/launchctl",
        args:         ["kickstart", "gui/#{Process.uid}/de.philipparndt.ai-pause"],
        must_succeed: false
  end

  zap delete: "~/Library/LaunchAgents/de.philipparndt.ai-pause.plist",
      trash:  "~/.config/ai-pause"

  caveats <<~EOS
    Start AI Pause now and at every login:
      ai-pause install-login
    Uninstalling keeps the login item; remove it with "ai-pause uninstall-login"
    first, or uninstall with --zap.
  EOS
end
