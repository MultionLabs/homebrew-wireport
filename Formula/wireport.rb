class Wireport < Formula
  desc "Self-hosted ingress proxy & VPN tunnel for exposing private services to the Internet"
  homepage "https://github.com/MultionLabs/wireport"
  version "0.9.5"
  
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.5/wireport-macos-arm64.zip"
      sha256 "444a465a682d21641d7d3bcf5d69e92c99e9de3613205613e58827d1172354b0"
    else
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.5/wireport-macos-amd64.zip"
      sha256 "06672efc6b2228dcca821542fbc2ccf5f8af32ebeab1b432392cd6af00b3f430"
    end
  end
  
  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.5/wireport-linux-arm64.tar"
      sha256 "d1cc190755b1460d7505e6d47a01fc505f0cf7038672b57407e32a8eec5d58ad"
    else
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.5/wireport-linux-amd64.tar"
      sha256 "5f2123e89f587dc6abf1a196c32b0ffd0faf36be4c2e1a59fd6857c200404097"
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
