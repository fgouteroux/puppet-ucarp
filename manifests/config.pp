class ucarp::config ($ucarp_enabled) {

  file { '/etc/ucarp-mvip':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    require => Class['ucarp::install'],
  }

  file { '/usr/share/ucarp-mvip':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    require => Class['ucarp::install'],
  }

  file { '/usr/share/ucarp-mvip/vip-up':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    source  => 'puppet:///modules/ucarp/vip-up',
    require => Class['ucarp::install'],
  }

  file { '/usr/share/ucarp-mvip/vip-down':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    source  => 'puppet:///modules/ucarp/vip-down',
    require => Class['ucarp::install'],
  }

  file { '/usr/share/ucarp-mvip/parseinterfaces.awk':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    source  => 'puppet:///modules/ucarp/parseinterfaces.awk',
    require => Class['ucarp::install'],
  }

  file { '/etc/init.d/ucarp-mvip':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    source  => 'puppet:///modules/ucarp/ucarp-mvip.init',
    require => Class['ucarp::install'],
  }

  file { '/etc/default/ucarp-mvip':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template("${module_name}/ucarp-mvip.default.erb"),
    require => Class['ucarp::install'],
  }
}
