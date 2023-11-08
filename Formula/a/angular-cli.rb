require "language/node"

class AngularCli < Formula
  desc "CLI tool for Angular"
  homepage "https://cli.angular.io/"
  url "https://registry.npmjs.org/@angular/cli/-/cli-17.0.0.tgz"
  sha256 "4d33a6fdc645417353130fc3e2d05eed4f8eb555490a4e44e34b4cbed13f74d1"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "eb0a5ef2de226db3d128a6792010870603c5e40f2bf035a9da9a2bfa790243c2"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "eb0a5ef2de226db3d128a6792010870603c5e40f2bf035a9da9a2bfa790243c2"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "eb0a5ef2de226db3d128a6792010870603c5e40f2bf035a9da9a2bfa790243c2"
    sha256 cellar: :any_skip_relocation, sonoma:         "0cac12fcca7121aa7f33a8cb0b863a8eb30590d53a54762725587aa6d50d0f3f"
    sha256 cellar: :any_skip_relocation, ventura:        "0cac12fcca7121aa7f33a8cb0b863a8eb30590d53a54762725587aa6d50d0f3f"
    sha256 cellar: :any_skip_relocation, monterey:       "0cac12fcca7121aa7f33a8cb0b863a8eb30590d53a54762725587aa6d50d0f3f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "eb0a5ef2de226db3d128a6792010870603c5e40f2bf035a9da9a2bfa790243c2"
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    system bin/"ng", "new", "angular-homebrew-test", "--skip-install"
    assert_predicate testpath/"angular-homebrew-test/package.json", :exist?, "Project was not created"
  end
end
