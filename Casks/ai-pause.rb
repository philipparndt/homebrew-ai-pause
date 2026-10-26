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

  # Homebrew runs these on upgrades too. A user-level bootout stops the login item
  # without the sudo that "launchctl:" uses, and keeps its plist, which postflight
  # loads again, so upgrades keep AI Pause running and starting at login.
  uninstall early_script: {
              executable:   "/bin/launchctl",
              args:         ["bootout", "gui/#{Process.uid}/de.philipparndt.ai-pause"],
              must_succeed: false,
            },
            quit:         "de.philipparndt.ai-pause"

  postflight do
    plist = "#{Dir.home}/Library/LaunchAgents/de.philipparndt.ai-pause.plist"
    if File.exist?(plist)
      system_command "/bin/launchctl", args: ["bootstrap", "gui/#{Process.uid}", plist], must_succeed: false
    end
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
