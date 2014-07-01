class ucarp::install {

  case $::operatingsystem {
    ubuntu, debian: {
      $package_name = 'ucarp'
    }
    default: {
      fail('Unsupported operating system')
    }
  }

  package { $package_name:
    ensure => installed,
  }
}
