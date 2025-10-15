class WireportAT096 < Formula
  desc "Self-hosted ingress proxy & VPN tunnel for exposing private services to the Internet"
  homepage "https://github.com/MultionLabs/wireport"
  version "0.9.6"
  
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.6/wireport-macos-arm64.zip"
      sha256 "829cbf56a9f16a75cfc44ccb210457873d9181120ac689476f64c2f33828d591"
    else
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.6/wireport-macos-amd64.zip"
      sha256 "c0f6ad220defc5326f97ad43aa4dd7d566091e8e0e25404e2a240a34543d3936"
    end
  end
  
  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.6/wireport-linux-arm64.tar"
      sha256 "a29898677916cb5e9a198ebe928d1b06e5d89ce8eb0d1e3b9895b8b6befd542a"
    else
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.6/wireport-linux-amd64.tar"
      sha256 "aad506acc9b8e7fe45bf195888b5a5259aa954c264f70bf18b4b95aa7318a7c0"
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
