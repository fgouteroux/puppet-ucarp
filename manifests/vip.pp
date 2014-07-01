define ucarp::vip (
  $ucarp_sub_interface,
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


}
