class WireportAT098 < Formula
  desc "Self-hosted ingress proxy & VPN tunnel for exposing private services to the Internet"
  homepage "https://github.com/MultionLabs/wireport"
  version "0.9.8"
  
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.8/wireport-macos-arm64.zip"
      sha256 "6e175df17b01181832d9d3c45fb423dcc0cc14feb4ad141ba4de746ad74ea128"
    else
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.8/wireport-macos-amd64.zip"
      sha256 "3477b1f780c96256cd789b0f077c199bb32f2e4e5dbffdf6ef88c9d16dc176d0"
    end
  end
  
  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.8/wireport-linux-arm64.tar"
      sha256 "9e30cef32b8deb346fcbfc277de37cb3b83a677bc22130484c70fe0144386bba"
    else
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.8/wireport-linux-amd64.tar"
      sha256 "c67b89f32de6593bc2806fb14d7596b8813381065b2df5e7a15be4c871f0f0f4"
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
