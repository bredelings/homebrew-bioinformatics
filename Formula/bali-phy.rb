class BaliPhy < Formula
  desc "Simultaneous Bayesian estimation of alignment and phylogeny"
  homepage "http://www.bali-phy.org/"

  stable do
    url "https://github.com/bredelings/BAli-Phy.git",
        :using => :git,
        :revision => "20fc9bd890220b99f76d0a3d4e7b9190370bb3bd"
    version "3.3"
  end

  head do
    url "https://github.com/bredelings/BAli-Phy.git", :using => :git
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "pandoc" => :build

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
