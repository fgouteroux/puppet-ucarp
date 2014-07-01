# Puppet UCARP Module

Module for UCARP Management

Tested on Debian 7.

### Usage
Tweak and add the following to your site manifest:
```
  class {'ucarp':}
```

If you want to manage ucarp on boot:
```
  class {'ucarp::config':
    ucarp_enabled => hiera('ucarp::enabled', 'no'),
  }
```

To create mutiple VIP on sub-interface:
```
  $ucarp_vip = hiera_hash('ucarp::vip', false)
    if $ucarp_vip {
      create_resources('ucarp::vip', $ucarp_vip)
    }
```

Example of Hieradata file:
```
ucarp::enabled: 'yes'
ucarp::vip:
  100:
    ucarp_sub_interface: 'eth1:100'
    ucarp_sub_interface_address: '10.0.0.1'
    ucarp_sub_interface_netmask: '255.255.255.0'
    ucarp_vip: '192.168.1.100'
    ucarp_vip_netmask: '255.255.255.255'
    ucarp_password: 'mypassword'
    ucarp_options: '--advskew 1 --advbase 1 --preempt --neutral'
```
