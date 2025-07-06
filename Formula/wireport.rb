class Wireport < Formula
  desc "Self-hosted ingress proxy & VPN tunnel for exposing private services to the Internet"
  homepage "https://github.com/MultionLabs/wireport"
  version "0.9.1"
  
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.1/wireport-macos-arm64.zip"
      sha256 "f5198ee94c14bcf04703aab4dc1c4ba0703c3177ff5e3a2ef8409009db14e689"
    else
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.1/wireport-macos-amd64.zip"
      sha256 "3077f6134d199d049e99a801bb00dd125d5d414088852879f294d3bcbe77891d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.1/wireport-linux-arm64.tar"
      sha256 "396364fc3e3f4e516862d9cd416d08423dc7ca4d19a8d589c8916bf87ee7e8ed"
    else
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.1/wireport-linux-amd64.tar"
      sha256 "291a095ce433e3b7a16f3a360884a8bc37f1117cf05f6ba27e6d0f6aa4658423"
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
