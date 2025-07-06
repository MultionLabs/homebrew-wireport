class Wireport < Formula
  desc "Self-hosted ingress proxy & VPN tunnel for exposing private services to the Internet"
  homepage "https://github.com/MultionLabs/wireport"
  version "0.9.1"
  
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.1/wireport-macos-arm64.zip"
      sha256 "32e62a34add1d448c775d49cf5235a2a2316bcaae828f429f51295c72613bf8e"
    else
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.1/wireport-macos-amd64.zip"
      sha256 "e5e0833a1578081e285c11bebdfbda57a72c12dac728686895e38313c045fc8e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.1/wireport-linux-arm64.tar"
      sha256 "cf8beae2fe50773eda66b47289098de0b063836c6b3e6fd07b9bbe0df7894fc0"
    else
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.1/wireport-linux-amd64.tar"
      sha256 "157a7f5d3dee7a8410b58269887169a2cf7c5d38acab6a2f79002b7d3cd8c0cc"
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
