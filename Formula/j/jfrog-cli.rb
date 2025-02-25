class JfrogCli < Formula
  desc "Command-line interface for JFrog products"
  homepage "https://www.jfrog.com/confluence/display/CLI/JFrog+CLI"
  url "https://github.com/jfrog/jfrog-cli/archive/refs/tags/v2.72.5.tar.gz"
  sha256 "394227ae2d46c53c0e359c25b5502428521a43af06f4692c9bfa27ee495a8a55"
  license "Apache-2.0"
  head "https://github.com/jfrog/jfrog-cli.git", branch: "v2"

  # There can be a notable gap between when a version is tagged and a
  # corresponding release is created, so we check the "latest" release instead
  # of the Git tags.
  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9fa5f0cee9bd4fcaead7308ccfc560fa3a54f811dc0f91c9b301b0c5c18d341d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "9fa5f0cee9bd4fcaead7308ccfc560fa3a54f811dc0f91c9b301b0c5c18d341d"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "9fa5f0cee9bd4fcaead7308ccfc560fa3a54f811dc0f91c9b301b0c5c18d341d"
    sha256 cellar: :any_skip_relocation, sonoma:        "32249fe651c4d00c507d2e08be993f86731d7827f7b2da4e3018609b979273a7"
    sha256 cellar: :any_skip_relocation, ventura:       "32249fe651c4d00c507d2e08be993f86731d7827f7b2da4e3018609b979273a7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4c693c0c4bc29046d6790ea809c57008872f8c2be65652da08d1cabaa76f4e34"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w", output: bin/"jf")
    bin.install_symlink "jf" => "jfrog"

    generate_completions_from_executable(bin/"jf", "completion")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/jf -v")
    assert_match version.to_s, shell_output("#{bin}/jfrog -v")
    with_env(JFROG_CLI_REPORT_USAGE: "false", CI: "true") do
      assert_match "build name must be provided in order to generate build-info",
        shell_output("#{bin}/jf rt bp --dry-run --url=http://127.0.0.1 2>&1", 1)
    end
  end
end
