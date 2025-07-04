class Wireport < Formula
  desc "Self-hosted ingress proxy & VPN tunnel for exposing private services to the Internet"
  homepage "https://github.com/MultionLabs/wireport"
  version "0.9.1"
  
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.1/wireport-macos-arm64.zip"
      sha256 "892984cfb35f1a742aa42ada59fc1042a24deb367dedabb2538fdc302781e463"
    else
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.1/wireport-macos-amd64.zip"
      sha256 "75060dcdd1f1cef601f74038435e9cacaf66bf08797ff672df38254ad3733ae8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.1/wireport-linux-arm64.tar"
      sha256 "9276889988acb406a744e5661fb591e123b88b9a754a6ff8ef7b8676d5dded1b"
    else
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.1/wireport-linux-amd64.tar"
      sha256 "9891bbf3e81125c0f8326f8f59e3256c36742efb008500370b11d34012664157"
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
