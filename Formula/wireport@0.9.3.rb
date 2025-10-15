class WireportAT093 < Formula
  desc "Self-hosted ingress proxy & VPN tunnel for exposing private services to the Internet"
  homepage "https://github.com/MultionLabs/wireport"
  version "0.9.3"
  
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.3/wireport-macos-arm64.zip"
      sha256 "5e4e75cbd9f264e22b0f453a90b6f208cf301d83903121058cbdc53a5981c445"
    else
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.3/wireport-macos-amd64.zip"
      sha256 "1fb0fcce498f26f21db9488ed730350be3f34f99a8db79f6c5d08424f9b457d3"
    end
  end
  
  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.3/wireport-linux-arm64.tar"
      sha256 "73454a9615fececc290dd8b8bfcbaaa1879f33f15bb03647cc7889d960f2ef6f"
    else
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.3/wireport-linux-amd64.tar"
      sha256 "9e03a4e9887a95330c420f6a66f17ffeace8a2dea32d33aa387c9e0d08efc6fb"
    end
  end
  
  license "MIT"
  
  def install
    if OS.mac?
      if Hardware::CPU.arm?
        bin.install "wireport-darwin-arm64" => "wireport"
      else
        bin.install "wireport-darwin-amd64" => "wireport"
      end
    elsif OS.linux?
      wireport_binary = Dir.glob("**/wireport").first
        if wireport_binary && File.executable?(wireport_binary)
            bin.install wireport_binary => "wireport"
        else
            raise "Could not find wireport binary in the extracted archive"
        end
      end
  end
  
  test do
    system "#{bin}/wireport", "--version"
  end
end
