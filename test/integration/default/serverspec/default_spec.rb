require 'spec_helper'

describe package('BBWin 0.13') do
  it { should be_installed }
end

describe service('bbwin') do
  it { should be_running }
  it { should be_enabled }
end

