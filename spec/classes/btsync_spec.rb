require 'spec_helper'

describe 'btsync', :type => :class do
  it { should contain_service("btsync").with(
    'ensure'    => 'true',
    'enable'    => 'true',
    )
  }
  it { should contain_file("/usr/bin/btsync").with(
    'ensure'  => 'present',
    'notify'  => 'Service[btsync]',
    )
  }
end
