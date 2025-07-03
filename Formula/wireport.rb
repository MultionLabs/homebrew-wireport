class Wireport < Formula
  desc "Self-hosted ingress proxy & VPN tunnel for exposing private services to the Internet"
  homepage "https://github.com/MultionLabs/wireport"
  version "0.9.1"
  
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.1/wireport-macos-arm64.zip"
      sha256 "a5811efb1b82c96f2347fa23eef466f5139e65b2d9cc3286d5233b1425738a71"
    else
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.1/wireport-macos-amd64.zip"
      sha256 "477a1cc221aa27fbacc48326790abc25c41abad626b423494863423a3030f534"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.1/wireport-linux-arm64.tar"
      sha256 "04639628de89dfcd6b16df1c1a2a9bd7a639ce12dde9208a1530fec26bc004f2"
    else
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.1/wireport-linux-amd64.tar"
      sha256 "6bb0c8aa2d6dd575483b77d7ed8f8b3ae7c362a6a8461ee5895191ffec8c9cfe"
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
      bin.install "usr/bin/wireport"
    end
  end

  test do
    system "#{bin}/wireport", "--version"
  end
end
