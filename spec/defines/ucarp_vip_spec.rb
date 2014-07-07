# spec/defines/ucarp_vip_spec.rb
require 'spec_helper'

describe 'ucarp::vip', :type => :define do

  let(:params) {
    { 'ucarp_sub_interface'         => 'eth1:100',
      'ucarp_sub_interface_address' => '10.0.0.1',
      'ucarp_sub_interface_netmask' => '255.255.255.0',
      'ucarp_vip'                   => '192.168.1.100',
      'ucarp_vip_netmask'           => '255.255.255.255',
      'ucarp_password'              => 'mypassword',
      'ucarp_options'               => '--advskew 1 --advbase 1 --preempt --neutral',
    }
  }

  let(:title) { '100' }
  it { should contain_file('/etc/ucarp-mvip/vip-100.conf').with_ensure('present') }

  it 'should have an augeas resource' do
    should contain_augeas('ucarp_interface-100')
  end

end



