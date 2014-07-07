# spec/classes/ucarp_spec.rb
require 'spec_helper'

describe 'ucarp', :type => :class do

  let :facts do
    {:operatingsystem =>'Debian'}
  end

  it { should contain_class('ucarp::install') }
  it { should contain_class('ucarp::config') }
  it { should contain_package('ucarp').with_ensure('installed') }
  it { should contain_file('/etc/ucarp-mvip').with_ensure('directory')}
  it { should contain_file('/usr/share/ucarp-mvip').with_ensure('directory')}
  it { should contain_file('/usr/share/ucarp-mvip/vip-up').with_ensure('present') }
  it { should contain_file('/usr/share/ucarp-mvip/vip-down').with_ensure('present') }
  it { should contain_file('/usr/share/ucarp-mvip/parseinterfaces.awk').with_ensure('present') }
  it { should contain_file('/etc/init.d/ucarp-mvip').with_ensure('present') }

end
