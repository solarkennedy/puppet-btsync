require 'spec_helper'

describe 'btsync', :type => :class do
  let :facts do
    {
      :osfamily               => 'Debian',
      :concat_basedir         => '/dne',
    }
  end
  it { should contain_service("btsync").with(
    'ensure'    => 'running',
    'enable'    => 'true',
    )
  }
  it { should contain_file("/usr/bin/btsync").with(
    'ensure'  => 'present',
    'notify'  => 'Service[btsync]',
    )
  }
end
