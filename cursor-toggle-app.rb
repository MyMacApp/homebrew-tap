class CursorToggleApp < Formula
  desc "Toggle cursor visibility from the toolbar"
  homepage "https://github.com/MyMacApp/cursor-toggle-app"
  url "https://github.com/MyMacApp/cursor-toggle-app/archive/v1.0.tar.gz"
  sha256 "0dc04d69df647738cccb299e0fc56eae067bafcd072679a6c9cff70b33149bec"
  license "MIT"

  depends_on xcode: ["11.0", :build]

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release"
    bin.install ".build/release/CursorToggleApp"
  end

  def post_install
    system "osascript", "-e", 'tell application "System Events" to make new login item at end with properties {path:"/usr/local/bin/CursorToggleApp", hidden:false}'
  end

  def plist
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>com.tokitake.cursor-toggle-app</string>
        <key>ProgramArguments</key>
        <array>
          <string>/usr/local/bin/CursorToggleApp</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>KeepAlive</key>
        <true/>
      </dict>
      </plist>
    EOS
  end
end
