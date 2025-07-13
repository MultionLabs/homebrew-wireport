class Wireport < Formula
  desc "Self-hosted ingress proxy & VPN tunnel for exposing private services to the Internet"
  homepage "https://github.com/MultionLabs/wireport"
  version "0.9.5"
  
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.5/wireport-macos-arm64.zip"
      sha256 "b93db6f5ce3252da2a967ad72e316e072367da99f6c68994dafd7222b20d670b"
    else
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.5/wireport-macos-amd64.zip"
      sha256 "8489749846750493cdf580776a7a0bfbf1e12902121e876e0d9cb7871259b89c"
    end
  end
  
  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.5/wireport-linux-arm64.tar"
      sha256 "617e5d925cca3c6ec2352cc4d3db8fd3296ce27293acc64d4d16ef4c88e1ec07"
    else
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.5/wireport-linux-amd64.tar"
      sha256 "197ed46138639b13028297cd0578feeff24615e0808694dff8f49e48b71ce913"
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
