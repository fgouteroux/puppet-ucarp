# === Define Resource Type: ucarp::vip
#
# This type will create virtual ip address and a sub-interface, on wich the VIP will be attached to.
#
# === Parameters
#
# [*ucarp_enabled*]
# Enable ucarp_mvip service on boot. Values: yes/no.
#
# [*ucarp_sub_interface*]
# Sub-interface name to create.
#
# [*ucarp_sub_interface_enabled*]
# Enabled the VIP after the run. Values: yes/no.
#
# [*ucarp_sub_interface_address*]
# Sub-interface ip address.
#
# [*ucarp_sub_interface_netmask*]
# Sub-interface netmask.
#
# [*ucarp_vip*]
# VIP address
#
# [*ucarp_vip_netmask*]
# VIP netmask
#
# [*ucarp_password*]
# VIP password
#
# [*ucarp_options*]
# VIP options. Type string, Value:"--advskew 1 --advbase 1 --preempt --neutral"
#
# Options:
#  --preempt (-P): becomes a master as soon as possible
#  --neutral (-n): don't run downscript at start if backup
#  --advbase=<seconds> (-b <seconds>): advertisement frequency
#  --advskew=<skew> (-k <skew>): advertisement skew (0-255)
#
# For more options "man ucarp"
#
define ucarp::vip (
  $ucarp_sub_interface,
  $ucarp_sub_interface_enabled,
  $ucarp_sub_interface_address,
  $ucarp_sub_interface_netmask,
  $ucarp_vip,
  $ucarp_vip_netmask,
  $ucarp_password,
  $ucarp_options) {

  $ucarp_vid = $name
  $ucarp_new_interface = "${ucarp_sub_interface}:ucarp"
  $config = "/etc/ucarp-mvip/vip-${ucarp_vid}.conf"
  $context = "/files/etc/network/interfaces"

  file { $config:
    ensure  => present,
    owner   => root,
    group   => root,
    content => template("${module_name}/vip.conf.erb"),
    require => Class["${module_name}::config"],
  }

  augeas{ "ucarp_sub_interface_${name}" :
    context => $context,
    changes => [
        "set auto[child::1 = '$ucarp_sub_interface']/1 $ucarp_sub_interface",
        "set iface[. = '$ucarp_sub_interface'] $ucarp_sub_interface",
        "set iface[. = '$ucarp_sub_interface']/family inet",
        "set iface[. = '$ucarp_sub_interface']/method static",
        "set iface[. = '$ucarp_sub_interface']/address $ucarp_sub_interface_address",
        "set iface[. = '$ucarp_sub_interface']/netmask $ucarp_sub_interface_netmask",
        "set iface[. = '$ucarp_new_interface'] $ucarp_new_interface",
        "set iface[. = '$ucarp_new_interface']/family inet",
        "set iface[. = '$ucarp_new_interface']/method static",
        "set iface[. = '$ucarp_new_interface']/address $ucarp_vip",
        "set iface[. = '$ucarp_new_interface']/netmask $ucarp_vip_netmask",
    ],
  }

  if $ucarp_sub_interface_enabled == 'yes' {
    exec{"/usr/share/ucarp-mvip/vip-up ${ucarp_sub_interface}":
      require => File[$config],
    }->

    exec { "Restart ucarp-mvip service for VIP ${name}":
      path    => ["/etc/init.d/"],
      command => "ucarp-mvip restart"
    }
  }
}

