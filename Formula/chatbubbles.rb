class Chatbubbles < Formula
  desc "Small HTTPS API for iMessage over Tailscale"
  homepage "https://github.com/kacy/chatbubbles"
  version "0.1.3"

  depends_on "imsg"
  depends_on macos: :sonoma

  if Hardware::CPU.arm?
    url "https://github.com/kacy/chatbubbles/releases/download/v0.1.3/chatbubbles_0.1.3_darwin_arm64.tar.gz"
    sha256 "66506fd9df7f4b3a0466022afda82d9907c6e20f174f804e387214f40ab6bfd3"
  else
    url "https://github.com/kacy/chatbubbles/releases/download/v0.1.3/chatbubbles_0.1.3_darwin_amd64.tar.gz"
    sha256 "4016dccda7bb693c423ffcb5bc877f28dfc2921b69bd857b7b89069b6f28546d"
  end

  def install
    bin.install "chatbubbles", "chatbubbles-cli"
    pkgshare.install "README.md"
  end

  def caveats
    <<~EOS
      chatbubbles still needs a few manual bits on top of the brew install:

      - install and sign in to tailscale on this mac
      - make sure Messages is signed in and working
      - grant full disk access to the terminal or daemon you use to run chatbubbles
      - grant automation permissions when macOS prompts for Messages control

      runtime state lives in:
        ~/.local/share/chatbubbles
    EOS
  end

  test do
    assert_match "listen address", shell_output("#{bin}/chatbubbles -h")
    assert_match "control socket path", shell_output("#{bin}/chatbubbles-cli -h 2>&1", 1)
  end
end
