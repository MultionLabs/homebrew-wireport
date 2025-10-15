class WireportAT094 < Formula
  desc "Self-hosted ingress proxy & VPN tunnel for exposing private services to the Internet"
  homepage "https://github.com/MultionLabs/wireport"
  version "0.9.4"
  
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.4/wireport-macos-arm64.zip"
      sha256 "ce536b5b7fa3277a173f8cb82015423929b6d9de5363cb1034b038520733656b"
    else
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.4/wireport-macos-amd64.zip"
      sha256 "e6bf606b46ed538bb51c6dd7fb02ad03a2bd8fca91c3b8faa3885c4c24520a66"
    end
  end
  
  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.4/wireport-linux-arm64.tar"
      sha256 "b753e375ba36cc56a575c3ec44a6863673bbcd5bfa119273ba281dda5503522a"
    else
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.4/wireport-linux-amd64.tar"
      sha256 "aeccf9e13b476236f100861b9ca2cc76dae7990f2b613a1268fd61151534da1f"
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
