class Chatbubbles < Formula
  desc "small https api for iMessage over tailscale"
  homepage "https://github.com/kacy/chatbubbles"
  version "0.1.3"

  depends_on macos: :sonoma
  depends_on "imsg"

  on_arm do
    url "https://github.com/kacy/chatbubbles/releases/download/v0.1.3/chatbubbles_0.1.3_darwin_arm64.tar.gz"
    sha256 "96566e1aa61e11f28a98f0075a9cbe58a1b560f2391582def5d8afd9626621a1"
  end

  on_intel do
    url "https://github.com/kacy/chatbubbles/releases/download/v0.1.3/chatbubbles_0.1.3_darwin_amd64.tar.gz"
    sha256 "a4465e28ffb956a6bf05bd6ca9d731d999957ae8bfe8bc2de1c4671142fc1003"
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
