require 'spec_helper'

describe package('BBWin 0.13') do
  it { should be_installed }
end

describe service('bbwin') do
  it { should be_running }
  it { should be_enabled }
end

describe file("#{ENV['SYSTEMDRIVE']}\\Program Files (x86)\\BBWin\\etc\\BBWin.cfg") do
  it { should be_file }
  it { should contain('setting name="bbdisplay" value="127.0.0.1"') }
end
