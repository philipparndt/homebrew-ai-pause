# typed: strict
# frozen_string_literal: true

cask "ai-pause" do
  version "0.2.0"
  sha256 "359bc280cca33adc97c5780e7ff56887f2c97bee7ca060f7e33ee46d99734d04"

  url "https://github.com/philipparndt/ai-pause/releases/download/v#{version}/AI-Pause-#{version}.zip"
  name "AI Pause"
  desc "Menu bar app that pauses AI coding agents during calls and games"
  homepage "https://github.com/philipparndt/ai-pause"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sonoma"

  app "AI Pause.app"
  binary "#{appdir}/AI Pause.app/Contents/MacOS/ai-pause"

  uninstall launchctl: "de.philipparndt.ai-pause",
            quit:      "de.philipparndt.ai-pause",
            delete:    "~/Library/LaunchAgents/de.philipparndt.ai-pause.plist"

  zap trash: "~/.config/ai-pause"

  caveats <<~EOS
    Start AI Pause now and at every login:
      ai-pause install-login
  EOS
end
