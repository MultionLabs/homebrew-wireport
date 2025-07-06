class Wireport < Formula
  desc "Self-hosted ingress proxy & VPN tunnel for exposing private services to the Internet"
  homepage "https://github.com/MultionLabs/wireport"
  version "0.9.1"
  
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.1/wireport-macos-arm64.zip"
      sha256 "e84e24679ff95e19da62f5e5ba7b654a9172c2782daf86c1ceb0f7f25256ccd2"
    else
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.1/wireport-macos-amd64.zip"
      sha256 "0edfbb8e113d189fe730b6cfc70ad8e8e73f681dc8d149160bb9e1331ca9d0ec"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.1/wireport-linux-arm64.tar"
      sha256 "9efcc993ef275954980fbe11c8215b102bc9a6e6c675369f0aecf3328126ac98"
    else
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.1/wireport-linux-amd64.tar"
      sha256 "c852314f3d82cb2118947056dd0f71429971002cd0284642cb529b75e702c4fc"
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
