# frozen_string_literal: true

require_relative "../lib/package_installer_cli"

RSpec.describe PackageInstallerCli do
  it "has a version number" do
    expect(PackageInstallerCli::VERSION).not_to be nil
  end

  describe ".run" do
    it "checks for Node.js availability" do
      allow(PackageInstallerCli).to receive(:system).with("node --version > /dev/null 2>&1").and_return(false)
      
      expect { PackageInstallerCli.run([]) }.to output(/Node.js is required/).to_stdout.and raise_error(SystemExit)
    end
  end
end