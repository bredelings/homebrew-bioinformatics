class BaliPhy < Formula
  desc "Simultaneous Bayesian estimation of alignment and phylogeny"
  homepage "http://www.bali-phy.org/"

  stable do
    url "https://github.com/bredelings/BAli-Phy.git",
        :using => :git,
        :revision => "e09be6497a881361887c7fc41c56bb36a068b3b3"
    version "3.1.4"
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
