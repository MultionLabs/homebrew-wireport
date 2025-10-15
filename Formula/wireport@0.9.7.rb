class WireportAT097 < Formula
  desc "Self-hosted ingress proxy & VPN tunnel for exposing private services to the Internet"
  homepage "https://github.com/MultionLabs/wireport"
  version "0.9.7"
  
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.7/wireport-macos-arm64.zip"
      sha256 "65411e1d769a468b1b83eb0d6bb9181e8f2bc414ec032536ec23d6f65b724793"
    else
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.7/wireport-macos-amd64.zip"
      sha256 "19c7e97fafe09ec1d20b6274529f3718552c63f60441081a5c086facd50edb22"
    end
  end
  
  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.7/wireport-linux-arm64.tar"
      sha256 "cd67ef890912dc2ab2f45225e8b18dc9badec02f6f9ed85e3fc2ca62983495db"
    else
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.7/wireport-linux-amd64.tar"
      sha256 "b2301e4f424212af9a63dfb12facdf05f33c12da4a1d16000a21b9f2d402f2d9"
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
