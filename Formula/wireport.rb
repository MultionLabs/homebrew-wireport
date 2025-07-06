class Wireport < Formula
  desc "Self-hosted ingress proxy & VPN tunnel for exposing private services to the Internet"
  homepage "https://github.com/MultionLabs/wireport"
  version "0.9.1"
  
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.1/wireport-macos-arm64.zip"
      sha256 "31b39e1b7022da5f05c93073f58e7faa3ffcadccaa489dcb230dcf9b565200ca"
    else
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.1/wireport-macos-amd64.zip"
      sha256 "e5d648bf45ec0dd73122e41cd46a46443e9d2eadee1896d63ae7b24229c00734"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.1/wireport-linux-arm64.tar"
      sha256 "42ac65b88b1f6487be49154aa4798e46d26caedcc90ae439a3dc296e817340eb"
    else
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.1/wireport-linux-amd64.tar"
      sha256 "0b9d6091561b5f6539c1d7a4c992b0dc2dbccd88d6df370a4471ae4647c4a1bd"
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
      # Find the wireport binary in the extracted tar contents
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
