# typed: strict
# frozen_string_literal: true

cask "ai-pause" do
  version "0.1.2"
  sha256 "7623d5800afdc32f9b7b3ef8fbe1f1212f4f74274c43a9f6acbb1f9570725047"

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
