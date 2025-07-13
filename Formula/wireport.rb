class Wireport < Formula
  desc "Self-hosted ingress proxy & VPN tunnel for exposing private services to the Internet"
  homepage "https://github.com/MultionLabs/wireport"
  version "0.9.5"
  
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.5/wireport-macos-arm64.zip"
      sha256 "f12e46bb57dd6d352563f81ad03a6b103c8aecfa9fd418940e6b7ed91b3561f3"
    else
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.5/wireport-macos-amd64.zip"
      sha256 "dd02e093ad8a6aa7c86ec0b2c19e714f944d27c82508fc17cd43fa2fccff7401"
    end
  end
  
  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.5/wireport-linux-arm64.tar"
      sha256 "f6362582ac30b9a192ec3bcc0352e431fac15b62bc7c7d141671ba9112551a9f"
    else
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.5/wireport-linux-amd64.tar"
      sha256 "1e1a6442ebdea42146ea68b9b234c8dc03f8bfa6d5605e9801ec51231c2f8807"
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
