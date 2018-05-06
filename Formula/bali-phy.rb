class BaliPhy < Formula
  desc "Simultaneous Bayesian estimation of alignment and phylogeny"
  homepage "http://www.bali-phy.org/"

  stable do
    url "https://github.com/bredelings/BAli-Phy.git",
        :using => :git,
        :revision => "adfbe44f0bb69a6e774f5041c06184e3e3039164"
    version "3.1.2"
  end

  head do
    url "https://github.com/bredelings/BAli-Phy.git", :using => :git
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
#  Meson breaks when we try to install docs currently.
#  depends_on "pandoc" => :build

  depends_on "cairo"

  needs :cxx14

  def install
    system 'meson', 'macbuild', "--prefix=#{prefix}", '-Dextra-tools=False'
    cd 'macbuild' do
      system 'ninja', 'install'
    end
  end

  test do
    system "#{bin}/bali-phy", "#{doc}/examples/sequences/5S-rRNA/5d.fasta", "--iter=150"
    system "#{bin}/bp-analyze", "5d-1"
  end
end
