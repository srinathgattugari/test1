require 'spec_helper'

describe package('openjdk-8-jdk') do
  it { should be_installed.with_version('8u212-b03-0ubuntu1.16.04.1') }
end

describe package('git') do
  it { should be_installed.with_version('1:2.7.4-0ubuntu1.6') }
end

describe package('xmlstarlet') do
  it { should be_installed }
end

describe file('/etc/systemd/system/jenkins.service') do
  it { should be_file }
  it { should be_mode '644' }
  its(:content) { should eq File.read('/tmp/verifier/suites/serverspec/files/expected_jenkins.service') }
end

describe file('/etc/systemd/system/jenkins_cleanup.service') do
  it { should be_file }
  it { should be_mode '644' }
  its(:content) { should eq File.read('/tmp/verifier/suites/serverspec/files/expected_jenkins_cleanup.service') }
end

describe file('/etc/systemd/system/jenkins_cleanup.timer') do
  it { should be_file }
  it { should be_mode '644' }
  its(:content) { should eq File.read('/tmp/verifier/suites/serverspec/files/expected_jenkins_cleanup.timer') }
end

describe file('/opt/workspace_and_build_cleanup.sh') do
  it { should be_file }
  it { should be_mode '755' }
  its(:content) { should eq File.read('/tmp/verifier/suites/serverspec/files/expected_workspace_and_build_cleanup.sh') }
end
