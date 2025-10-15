class WireportAT095 < Formula
  desc "Self-hosted ingress proxy & VPN tunnel for exposing private services to the Internet"
  homepage "https://github.com/MultionLabs/wireport"
  version "0.9.5"
  
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.5/wireport-macos-arm64.zip"
      sha256 "6e70ed73a71c2d413c957c3cab999e572fd0fe6b919c77110e963933fb865f3a"
    else
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.5/wireport-macos-amd64.zip"
      sha256 "de9a4118553b8e2b1751c3f0beec9f83e934e48f84586a4e96f98f47536f72a8"
    end
  end
  
  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.5/wireport-linux-arm64.tar"
      sha256 "9d8870c1654450baeab32f5f899c364889b31e8390f3bf25c09c3d461227f494"
    else
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.5/wireport-linux-amd64.tar"
      sha256 "c1688dc3db96cd1dbbf401f88b316ba185fb1a1e6a963fae1c49b11ba6ced1b6"
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
