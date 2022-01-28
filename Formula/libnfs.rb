class Libnfs < Formula
  desc "C client library for NFS"
  homepage "https://github.com/sahlberg/libnfs"
  url "https://github.com/sahlberg/libnfs/archive/libnfs-5.0.1.tar.gz"
  sha256 "7ef445410b42f36b9bad426608b53ccb9ccca4101e545c383f564c11db672ca8"
  license "LGPL-2.1-or-later"

  bottle do
    sha256 cellar: :any,                 arm64_monterey: "fbdc6289471866174d2bf53bb6dc06f1aab5355e8277f876885a958e83ae427c"
    sha256 cellar: :any,                 arm64_big_sur:  "de91ee7dc3d0e20a1590b6b2d46e4ca46eb123969cf0d07513514bf2a993cc4c"
    sha256 cellar: :any,                 monterey:       "4cee9dc77a8d62d65901c793c1ffb57c6a278ea689a105ac5c55decc82ca5cf0"
    sha256 cellar: :any,                 big_sur:        "9699bde5c013daa2950ec8ee012c4ced65bd9ea99005d0e0db2ee5336700742e"
    sha256 cellar: :any,                 catalina:       "d727464baa3bbd6111f7b791ae67da3573e47be5d7d613c314853e581743f941"
    sha256 cellar: :any,                 mojave:         "e51a653f469f19db8c24f009166b7c63a3d9e48ffd16e687d81e2fc0da52f632"
    sha256 cellar: :any,                 high_sierra:    "2c6199b4295a952c6c179811c9190c8741054011f23ed5a051528baf07b44509"
    sha256 cellar: :any,                 sierra:         "668a6d77334fd656ea8ca32c1bb36c9253fb95f1dc701607d722afa6af6aa737"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1cdce4e9a6a631faa75a5a58db727ec6105c2d970b10c42cc800060efa040f88"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    system "./bootstrap"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"

    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #if defined(__linux__)
      # include <sys/time.h>
      #endif
      #include <stddef.h>
      #include <nfsc/libnfs.h>

      int main(void)
      {
        int result = 1;
        struct nfs_context *nfs = NULL;
        nfs = nfs_init_context();

        if (nfs != NULL) {
            result = 0;
            nfs_destroy_context(nfs);
        }

        return result;
      }
    EOS
    system ENV.cc, "test.c", "-L#{lib}", "-lnfs", "-o", "test"
    system "./test"
  end
end
