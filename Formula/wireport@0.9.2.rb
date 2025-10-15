class WireportAT092 < Formula
  desc "Self-hosted ingress proxy & VPN tunnel for exposing private services to the Internet"
  homepage "https://github.com/MultionLabs/wireport"
  version "0.9.2"
  
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.2/wireport-macos-arm64.zip"
      sha256 "8fe92392ca8ece4b65dcfa972c20d0a5aa70406626dae60794ee33c76484c41b"
    else
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.2/wireport-macos-amd64.zip"
      sha256 "49b544eda30ff5d3b3bfd24165af8d1c8702ff2f915b57f4e4c047ac0b3a42fc"
    end
  end
  
  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.2/wireport-linux-arm64.tar"
      sha256 "18bfb7b0d51d117e750e7f1e92b43838dd81269503e577ce24cf4fe660faa531"
    else
      url "https://github.com/MultionLabs/wireport/releases/download/v0.9.2/wireport-linux-amd64.tar"
      sha256 "e7833efced8ec2aeb1768090416aae81da81273edf50adc18548098f13910960"
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
