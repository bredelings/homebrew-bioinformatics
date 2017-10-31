class BaliPhy < Formula
  desc "Simultaneous Bayesian estimation of alignment and phylogeny"
  homepage "http://www.bali-phy.org/"

  stable do
    url "https://github.com/bredelings/BAli-Phy.git",
        :using => :git,
        :revision => "2568a91ae6844ab7c96068838baae25286b3333a"
    version "3.0-beta4+1"
  end

#  bottle do
#    sha256 "50fa703af91bb78303464e6e02db8603e8722e01a1275c8cc6b44254b9dacfab" => :sierra
#    sha256 "62fa80287c762052da28393ff946765c1390c1da0c917cdbac6e98f0600856e9" => :el_capitan
#    sha256 "9a243403ab53dc740dbfb5f34eb829fd4aa777bed544ece0d09c040994ad0b14" => :yosemite
#    sha256 "86b5806848c469aaae1df3417ccfcba46468f251765235bb33036678a7176d15" => :x86_64_linux
#  end

  head do
    url "https://github.com/bredelings/BAli-Phy.git", :using => :git
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "cairo"

  needs :cxx14

  def install
    system "./bootstrap.sh"
    mkdir "macbuild" do
      system "../configure", "--disable-debug",
                             "--disable-dependency-tracking",
                             "--prefix=#{prefix}"
      system "make", "install"
    end
  end

  test do
    system "#{bin}/bali-phy", "#{pkgshare}/examples/sequences/5S-rRNA/5d.fasta", "--iter=150"
    system "#{bin}/bp-analyze.pl", "5d-1"
  end
end
