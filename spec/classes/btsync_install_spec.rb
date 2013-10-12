require 'spec_helper'

describe 'btsync::install', :type => :class do
  context "On Debian OSes" do
    let :facts do
      {
        :osfamily               => 'Debian',
        :concat_basedir         => '/dne',
      }
    end
    it { should contain_file("/usr/bin/btsync").with(
      'ensure'  => 'present'
      )
    }
  end
end
